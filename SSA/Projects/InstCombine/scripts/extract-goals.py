#!/usr/bin/env python3
# This script extracts goal states from Lean files in the
# 'SSA/Projects/InstCombine/tests/proofs' directory.
# This ensures that there is one goal state per file,
# which makes scripting much easier.
import concurrent.futures
import subprocess
import datetime
import platform
import argparse
import shutil
from typing import List
from pathlib import Path
from dataclasses import dataclass, asdict
import pandas as pd
import os
import re
import logging
import random
import json

ROOT_DIR = subprocess.check_output(['git', 'rev-parse', '--show-toplevel']).decode('utf-8').strip()
BENCHMARK_DIR = ROOT_DIR + '/SSA/Projects/InstCombine/tests/proofs/'
GOALS_DIR = ROOT_DIR + '/SSA/Projects/InstCombine/tests/goals/'

STATUS_FAIL = "❌"
STATUS_GREEN_CHECK = "✅"
STATUS_SUCCESS = "🎉"
STATUS_PROCESSING = "🕒"

def sed():
    if platform.system() == "Darwin":
        return "gsed"
    return "sed"

@dataclass
class Theorem:
    # the name of the theorem.
    name : str
    # the text of the theorem, including 'theorem <name> <args> := by sorry
    text : str

def extract_theorems(raw : str) -> List[Theorem]:
    out = []
    raw = raw.strip()
    ss = re.findall(r'(theorem.*?:= sorry)', raw, re.DOTALL)
    for s in ss:
        # grab the theorem name.
        thm_name = re.search(r'\btheorem\s+([\w._]+)', s).group(1)
        if not thm_name:
            logging.warning(f"{fileTitle}({file_num}): Failed to extract theorem name from theorem string {s}")
            continue
        thm = Theorem(name=thm_name, text=s.strip())
        out.append(thm)
    return out


def run_file(db : str, file: str, file_num : int, nfiles : int, timeout : int):
    file_path = BENCHMARK_DIR + file
    fileTitle = file.split('.')[0]
    EXTRACT_GOALS = "extract_goals"
    logging.info(f"{fileTitle}: writing '{EXTRACT_GOALS}' tactic into file #{file_num}.")
    subprocess.Popen(f'{sed()} -i -E \'s,simp_alive_benchmark,{EXTRACT_GOALS},g\' ' + file_path, cwd=ROOT_DIR, shell=True).wait()

    cmd = 'lake lean ' + file_path
    logging.info(f"{fileTitle}({file_num}/{nfiles}): running '{cmd}'")

    # TODO: can check that file exists to skip.
    p = subprocess.Popen(cmd, cwd=ROOT_DIR, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True, universal_newlines=True)
    logging.info(f"{fileTitle}({file_num}/{nfiles}): running...")
    try:
        out, err = p.communicate(timeout=timeout)
    except subprocess.TimeoutExpired as e:
        logging.info(f"{file_path} - time out of {TIMEOUT} seconds reached")
        p.kill()
        return False

    logging.info(f"{fileTitle}({file_num}/{nfiles}): done processing.")
    if p.returncode != 0:
        logging.error(f"{fileTitle}({file_num}/{nfiles}) {STATUS_FAIL}: Expected return code of 0, found {p.returncode}")

    # split 'out' into parts that are delimited by 'theorem ... := sorry'.
    theorems = extract_theorems(out)
    with open(db, "a") as f:
        f.write(json.dumps({
            "fileTitle": fileTitle,
            "contents": out,
            "theorems": [asdict(t) for t in theorems]
            }) + "\n")

    for t in theorems:
        path = Path(GOALS_DIR) / f"{fileTitle}_{t.name}.lean"
        with open(path, 'w') as f:
            f.write(t.text)
            logging.info(f"{fileTitle}({file_num}/{nfiles}): {STATUS_GREEN_CHECK} Extracted {path}")
    return True

def process(db : str, jobs: int, nfiles: int, timeout : int):
    tactic_auto_path = f'{ROOT_DIR}/SSA/Projects/InstCombine/TacticAuto.lean'

    if os.path.exists(db):
        os.remove(db)

    logging.info(f"Clearing git state of '{BENCHMARK_DIR}' with 'git checkout --'")
    gco = subprocess.Popen(f'git checkout -- {BENCHMARK_DIR}', cwd=ROOT_DIR, shell=True)
    gco.wait()
    assert gco.returncode == 0, f"git checkout -- {BENCHMARK_DIR} should succeed."


    raw_files = list(os.listdir(BENCHMARK_DIR))

    files = []
    for ix, file in enumerate(raw_files):
        if "_proof" in file:
            files.append(file)
            if len(files) > nfiles:
                break # quit if we are not doing a production run after 5 files.

    total = len(files)
    logging.info(f"total #files to process: {total}")
    num_completed = 0
    future2file = {}
    with concurrent.futures.ThreadPoolExecutor(max_workers=jobs) as executor:
        for ix, file in enumerate(files):
            future = executor.submit(run_file, db, file, ix + 1, total, timeout)
            future2file[future] = file

    total = len(future2file)
    assert len(future2file) == len(files)
    for future in concurrent.futures.as_completed(future2file):
        file = future2file[future]
        try:
            success = future.result()
        except Exception as exc:
            success = False
            logging.error('%r FAILED with exception: %s' % (file, exc))
        else:
            if not success:
                logging.error('%r FAILED run' % (file))

        percentage = ((ix + 1) / total) * 100
        status_symbol = STATUS_SUCCESS if success else STATUS_FAIL
        logging.info(f'{status_symbol} completed {file} ({percentage:.1f}%)')
        num_completed += 1
        logging.info(f"total #files processed: {num_completed}/{total}")

    if num_completed != total:
        logging.error(f"Expected {total} files to be processed, but got {num_completed} completed futures.")

def setup_logging(db_name : str):
    # Set up the logging configuration
    logging.basicConfig(level=logging.DEBUG,
        format='%(asctime)s - %(levelname)s - %(message)s',
        handlers=[logging.FileHandler(f'{db_name}.log', mode='a'), logging.StreamHandler()])

if __name__ == "__main__":
  current_time = datetime.datetime.now().strftime('%Y-%m-%d-%H:%M:%S')
  nproc = os.cpu_count()
  parser = argparse.ArgumentParser(prog='extract-goals')
  default_db = f'extract-goals-{current_time}.jsonl'
  parser.add_argument('--db', default=default_db, help='path to jsonl database')
  parser.add_argument('-j', '--jobs', type=int, default=1)
  parser.add_argument('--nfiles', type=int, default=4, help="number of files to extract")
  parser.add_argument('--timeout', type=int, default=600, help="timeout in seconds for each file processing")
  args = parser.parse_args()
  setup_logging(args.db)
  logging.info(args)
  process(args.db, jobs=args.jobs, nfiles=args.nfiles, timeout=args.timeout)

