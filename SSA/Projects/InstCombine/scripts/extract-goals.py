# This script extracts goal states from Lean files in the SSA/Projects/InstCombine/tests/proofs directory.
#!/usr/bin/env python3
import concurrent.futures
import subprocess
import datetime
import platform
import argparse
import shutil
from pathlib import Path
import pandas as pd
import os
import re
import logging
import random
import json
from dataclasses import dataclass, asdict

ROOT_DIR = subprocess.check_output(['git', 'rev-parse', '--show-toplevel']).decode('utf-8').strip()
BENCHMARK_DIR = ROOT_DIR + '/SSA/Projects/InstCombine/tests/proofs/'
GOALS_DIR = ROOT_DIR + '/SSA/Projects/InstCombine/tests/goals/'

STATUS_FAIL = "❌"
STATUS_GREEN_CHECK = "✅"
STATUS_SUCCESS = "🎉"
STATUS_PROCESSING = "⌛️"

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
    theorems = [x for x in re.split(r'(?=theorem)', raw) if x]
    for t in theorems:
        # grab the theorem name.
        thm_name = re.search(r'\btheorem\s+([\w._]+)', t).group(1)
        if not thm_name:
            logging.warning(f"{fileTitle}({file_num}): Failed to extract theorem name from theorem string {t}")
            continue
        out.append(Theorem(name=thm_name, text=t))
    return out


def run_file(db : str, file: str, file_num : int, timeout : int):
    file_path = BENCHMARK_DIR + file
    fileTitle = file.split('.')[0]
    logging.info(f"{fileTitle}: writing 'bv_bench_automata' tactic into file #{file_num}.")
    EXTRACT_GOALS = "extract_goals"
    subprocess.Popen(f'{sed()} -i -E \'s,simp_alive_benchmark,{EXTRACT_GOALS},g\' ' + file_path, cwd=ROOT_DIR, shell=True).wait()
    logging.info(f"{fileTitle}: {STATUS_PROCESSING}")

    cmd = 'lake lean ' + file_path
    logging.info(f"{fileTitle}({file_num}): running '{cmd}'")

    # TODO: can check that file exists to skip.
    p = subprocess.Popen(cmd, cwd=ROOT_DIR, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True, universal_newlines=True)
    logging.info(f"{fileTitle}({file_num}): running...")
    try:
        out, err = p.communicate(timeout=timeout)
    except subprocess.TimeoutExpired as e:
        logging.info(f"{file_path} - time out of {TIMEOUT} seconds reached")
        p.kill()
        return False

    logging.info(f"{fileTitle}({file_num}): done processing.")
    if p.returncode != 0:
        logging.error(f"{fileTitle}({file_num}) {STATUS_FAIL}: Expected return code of 0, found {p.returncode}")

    # split 'out' into parts that are delimited by 'theorem ...'.
    theorems = extract_theorems(out)
    with open(db, "a") as f:
        f.write(json.dumps({
            "fileTitle": fileTitle,
            "output": out,
            "theorems": [asdict(t) for t in theorems]
            }) + "\n")

    for t in theorems:
        with open(Path(GOALS_DIR) / f"{fileTitle}_{t.name}.lean", 'w') as f:
            f.write(t)
            logging.info(f"{fileTitle}({file_num}) {STATUS_SUCESS}: Extracted theorem {t.name}")

def process(db : str, jobs: int, nfiles: int, timeout : int)
    tactic_auto_path = f'{ROOT_DIR}/SSA/Projects/InstCombine/TacticAuto.lean'

    if os.path.exists(db):
        os.remove(db)

    logging.info(f"Clearing git state of '{BENCHMARK_DIR}' with 'git checkout --'")
    gco = subprocess.Popen(f'git checkout -- {BENCHMARK_DIR}', cwd=ROOT_DIR, shell=True)
    gco.wait()
    assert gco.returncode == 0, f"git checkout -- {BENCHMARK_DIR} should succeed."


    logging.info(f"Running a 'lake exe cache get && lake build'.")
    lake = subprocess.Popen(f'lake exe cache get && lake build', cwd=ROOT_DIR, shell=True)
    lake.wait()
    assert lake.returncode == 0, f"lake build should succeed before running evaluation."

    raw_files = list(os.listdir(BENCHMARK_DIR))

    files = []
    for ix, file in enumerate(raw_files):
        if "_proof" in file:
            files.append(file)
            if len(files) > ntests:
                break # quit if we are not doing a production run after 5 files.

    total = len(files)
    logging.info(f"total #files to process: {total}")
    num_completed = 0
    future2file = {}
    with concurrent.futures.ThreadPoolExecutor(max_workers=jobs) as executor:
        for ix, file in enumerate(files):
            future = executor.submit(run_file, db, file, ix + 1, timeout)
            future2file[future] = file

    total = len(future2file)
    assert len(future2file) == len(files)
    for future in concurrent.futures.as_completed(future2file):
        file = future2file[future]
        try:
            success = future.result()
        except Exception as exc:
            logging.error('%r FAILED with exception: %s' % (file, exc))
        else:
            if not success:
                logging.error('%r FAILED run' % (file))

        percentage = ((ix + 1) / total) * 100
        logging.info(f'{STATUS_GREEN_CHECK} completed {file} ({percentage:.1f}%)')
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
  parser = argparse.ArgumentParser(prog='compare-automata-automata-circuit')
  default_db = f'automata-circuit-{current_time}.jsonl'
  parser.add_argument('--db', default=default_db, help='path to jsonl database')
  parser.add_argument('-j', '--jobs', type=int, default=1)
  parser.add_argument('--nfiles', type=int, default=4, help="number of files to extract")
  parser.add_argument('--timeout', type=int, default=600, help="timeout in seconds for each file processing")
  args = parser.parse_args()
  setup_logging(args.db)
  logging.info(args)
  process(args.db, jobs=args.jobs, nfiles=args.nfiles, timeout=args.timeout)

