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

SCRIPT_PATH = os.path.relpath(os.path.abspath(__file__), ROOT_DIR)


PREAMBLE = f"""
/-
-- auto-generated from '{SCRIPT_PATH}'
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false
-/

"""

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

    def get_file_name(self, file_title: str) -> str:
        suffix = self.name.replace('.', '_').replace(' ', '_')
        return f"{file_title}_{suffix}.lean"

def extract_theorems(raw : str) -> List[Theorem]:
    out = []
    raw = raw.strip()
    ss = re.findall(r'(theorem.*?sorry)', raw, re.DOTALL)
    # TODO: add goal index? but that's also there in the theorem name.
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
    logging.debug(f"{fileTitle}({file_num}/{nfiles}): running '{cmd}'")

    # TODO: can check that file exists to skip.
    p = subprocess.Popen(cmd, cwd=ROOT_DIR, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True, universal_newlines=True)
    logging.debug(f"{fileTitle}({file_num}/{nfiles}): running...")
    try:
        out, err = p.communicate(timeout=timeout)
    except subprocess.TimeoutExpired as e:
        logging.error(f"{file_path} - time out of {TIMEOUT} seconds reached")
        p.kill()
        return False

    logging.debug(f"{fileTitle}({file_num}/{nfiles}): done processing.")
    if p.returncode != 0:
        logging.error(f"{fileTitle}({file_num}/{nfiles}) {STATUS_FAIL}: Expected return code of 0, found {p.returncode}")

    # split 'out' into parts that are delimited by 'theorem ... := sorry'.
    theorems = extract_theorems(out)
    logging.debug(f"{fileTitle}({file_num}/{nfiles}) Extracted {len(theorems)} theorems.")
    if not theorems:
        logging.error(f"{fileTitle}({file_num}/{nfiles}) {STATUS_FAIL}: No theorems extracted from file {file_path}.")
        return False

    with open(db, "a") as f:
        for t in theorems:
            f.write(json.dumps({
                "fileTitle": fileTitle,
                "theorem_name": t.name,
                "theorem_text": t.text,
                }) + "\n")

    for t in theorems:
        path = Path(GOALS_DIR) / t.get_file_name(fileTitle)
        logging.info(f"{fileTitle}({file_num}/{nfiles}): Writing '{path}'...")
        with open(path, 'w') as f:
            f.write(PREAMBLE)
            f.write(t.text)
            logging.info(f"{fileTitle}({file_num}/{nfiles}): {STATUS_GREEN_CHECK} Written to '{path}'")
    return True

def process(args):
    db = args.db
    jobs = args.jobs
    nfiles = args.nfiles
    timeout = args.timeout
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

    logging.info(f"total #files to process: {len(files)}, stride={args.stride}, offset={args.offset}")
    files = [files[i] for i in range(args.offset, len(files), args.stride)]
    total = len(files)
    logging.info(f"picked #files w/stride and offset: {total}")
    num_completed = 0
    future2file = {}
    with concurrent.futures.ThreadPoolExecutor(max_workers=jobs) as executor:
        for ix, file in enumerate(files):
            future = executor.submit(run_file, db, file, ix + 1, total, timeout)
            future2file[future] = file

    assert len(future2file) == len(files)
    for future in concurrent.futures.as_completed(future2file):
        file = future2file[future]

        success = False
        try:
            success = future.result()
        except Exception as exc:
            success = False
            logging.error('%r FAILED with exception: %s' % (file, exc))
        if not success:
            logging.error('%r FAILED run' % (file))

        percentage = ((ix + 1) / total) * 100
        status_symbol = STATUS_SUCCESS if success else STATUS_FAIL
        num_completed += 1
        if ix % 100 == 1:
          logging.debug(f'{status_symbol} completed {file} ({percentage:.1f}%)')
          logging.debug(f"total #files processed: {num_completed}/{total}")

    if num_completed != total:
        logging.error(f"Expected {total} files to be processed, but got {num_completed} completed futures.")

def setup_logging(db_name : str):
    # Set up the logging configuration
    logging.basicConfig(level=os.environ.get('LOGLEVEL', 'DEBUG').upper(),
        format='%(asctime)s - %(levelname)s - %(message)s',
        handlers=[logging.FileHandler(f'{db_name}.log', mode='a'), logging.StreamHandler()])

if __name__ == "__main__":
  current_time = datetime.datetime.now().strftime('%Y-%m-%d-%H:%M:%S')
  nproc = os.cpu_count()
  parser = argparse.ArgumentParser(prog='extract-goals')
  default_db = f'extract-goals-{current_time}.jsonl'
  parser.add_argument('--db', default=default_db, help='path to jsonl database')
  parser.add_argument('-j', '--jobs', type=int, default=4)
  parser.add_argument('--nfiles', type=int, default=4, help="number of files to extract")
  parser.add_argument('--timeout', type=int, default=600, help="timeout in seconds for each file processing")
  parser.add_argument('--stride', type=int, default=1, help="Files that are processed have index 'ix = ∃ k, stride * k + offset'")
  parser.add_argument('--offset', type=int, default=0, help="Files that are processed have index 'ix = ∃ k, stride * k + offset'")
  args = parser.parse_args()
  setup_logging(args.db)
  logging.info(args)
  process(args)

