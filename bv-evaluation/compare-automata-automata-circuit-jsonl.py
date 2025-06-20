#!/usr/bin/env python3
import subprocess
import datetime
import os
import platform
import argparse
import shutil
import pandas as pd
import os
import re
import logging
import random
import json

ROOT_DIR = subprocess.check_output(['git', 'rev-parse', '--show-toplevel']).decode('utf-8').strip()
BENCHMARK_DIR = ROOT_DIR + '/SSA/Projects/InstCombine/tests/proofs/'
TIMEOUT = 1800 # timeout

STATUS_FAIL = "❌"
STATUS_GREEN_CHECK = "✅"
STATUS_SUCCESS = "🎉"
STATUS_PROCESSING = "⌛️"

def sed():
    if platform.system() == "Darwin":
        return "gsed"
    return "sed"

def run_file(db : str, file: str, file_num : int):
    assert 0 < file_num, "file_num must be greater than 0"
    file_path = BENCHMARK_DIR + file
    fileTitle = file.split('.')[0]
    logging.info(f"{fileTitle}: writing 'bv_bench_automata' tactic into file #{file_num}.")
    subprocess.Popen(f'{sed()} -i -E \'s,simp_alive_benchmark,bv_bench_automata,g\' ' + file_path, cwd=ROOT_DIR, shell=True).wait()
    logging.info(f"{fileTitle}: {STATUS_PROCESSING}")

    cmd = 'lake lean ' + file_path
    logging.info(f"{fileTitle}({file_num}): running '{cmd}'")

    # TODO: can check that file exists to skip.
    p = subprocess.Popen(cmd, cwd=ROOT_DIR, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True, universal_newlines=True)
    logging.info(f"{fileTitle}({file_num}): running...")
    try:
        out, err = p.communicate(timeout=TIMEOUT)
    except subprocess.TimeoutExpired as e:
        logging.info(f"{file_path} - time out of {TIMEOUT} seconds reached")
        p.kill()
        return None

    logging.info(f"{fileTitle}({file_num}): done.")
    logging.info(out)
    if p.returncode != 0:
        logging.error(f"{fileTitle}({file_num}): Expected return code of 0, found {p.returncode}")
        assert p.returncode == 0

    records = []
    for line in out.strip().split("\n"):
        TACBENCH_PREAMBLE = "TACBENCHCSV|"
        COLS = ["thmName", "goalStr", "tactic", "status", "errmsg", "timeElapsed"]
        if line.startswith(TACBENCH_PREAMBLE):
            line = line.removeprefix(TACBENCH_PREAMBLE)
            row = line.split(", ")
            assert len(row) == len(COLS)
            record = dict(zip(COLS, row))
            record["fileTitle"] = fileTitle
            records.append(record)

    with open(f"{db}", "a") as f:
        for record in records:
            f.write(json.dumps(record) + "\n")

def process(db : str, jobs: int, prod_run : bool):
    tactic_auto_path = f'{ROOT_DIR}/SSA/Projects/InstCombine/TacticAuto.lean'
    # os.makedirs(os.path.dirname(db), exist_ok=True)

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
        if "_proof" in file and "gandhorhicmps_proof" not in file: # currently discard broken chapter
            files.append(file)
            N_TEST_RUN_FILES = 5
            if len(files) == N_TEST_RUN_FILES and not prod_run:
                break # quit if we are not doing a production run after 5 files.

    total = len(files)
    logging.info(f"total #files to process: {total}")
    num_completed = 0
    for ix, file in enumerate(files):
        future = run_file(db, file, ix+1)
        percentage = ((ix + 1) / total) * 100
        logging.info(f'completed {file} ({percentage:.1f}%)')
        num_completed += 1
        logging.info(f"total #files processed: {num_completed}")

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
  parser.add_argument('--run', action='store_true', help="run evaluation")
  parser.add_argument('--prodrun', action='store_true', help="run production run of evaluation")
  args = parser.parse_args()
  setup_logging(args.db)
  logging.info(args)
  if args.run:
    process(args.db, args.jobs, prod_run=False)
  elif args.prodrun:
    process(args.db, args.jobs, prod_run=True)
  else:
    logging.error("expected --run or --prodrun.")

