#!/usr/bin/env python3
import subprocess
import datetime
import os
import platform
import concurrent.futures
import argparse
import shutil
import pandas as pd
import os
import re
import sqlite3
import logging
import random
from tabulate import tabulate

ROOT_DIR = subprocess.check_output(['git', 'rev-parse', '--show-toplevel']).decode('utf-8').strip()
BENCHMARK_DIR = ROOT_DIR + '/SSA/Projects/InstCombine/tests/proofs/'
TIMEOUT = 1800 # timeout

STATUS_FAIL = "❌",
STATUS_GREEN_CHECK = "✅",
STATUS_SUCCESS = "🎉",
STATUS_PROCESSING = "⌛️"

def sed():
    if platform.system() == "Darwin":
        return "gsed"
    return "sed"

def run_file(db : str, file: str):
    file_path = BENCHMARK_DIR + file
    fileTitle = file.split('.')[0]

    logging.info(f"{fileTitle}: Cache lookup, Opening connection...")
    con = sqlite3.connect(db)
    cur = con.cursor()
    # Check if there is a row with the given fileTitle and timeout
    logging.info(f"{fileTitle}: Cache lookup, SELECTING for existing data...")
    cur.execute("""
        SELECT 1 FROM completedFiles WHERE fileTitle = ? LIMIT 1
    """, (fileTitle, ))
    # Fetch the result, if no rows exist, the result will be an empty list
    result = cur.fetchone()
    con.close()
    if result is not None:
        logging.info(f"{fileTitle}: cache hit, skipping ⏭️")
        return
    else:
        logging.info(f"{fileTitle}: cache miss, processing ▶️")

    logging.info(f"{fileTitle}: writing 'bv_bench_automata' tactic into file.")
    subprocess.Popen(f'{sed()} -i -E \'s,simp_alive_benchmark,bv_bench_automata,g\' ' + file_path, cwd=ROOT_DIR, shell=True).wait()
    logging.info(f"{fileTitle}: {STATUS_PROCESSING}")

    cmd = 'lake lean ' + file_path
    logging.info(f"{fileTitle}: running '{cmd}'")
    try:
        p = subprocess.Popen(cmd, cwd=ROOT_DIR, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True, universal_newlines=True)
        logging.info(f"{fileTitle}: running...")
        out, err = p.communicate(timeout=TIMEOUT)
        logging.info(f"{fileTitle}: done.")
        logging.info(out)
        if p.returncode != 0:
            logging.info(f"ERROR: Expected return code of 0, found {p.returncode}")
            logging.info(f"{fileTitle} stderr: {err}")
            assert p.returncode == 0
        logging.info(f"{fileTitle} output:\n{out}")
        for line in out.strip().split("\n"):
            TACBENCH_PREAMBLE = "TACBENCHCSV|"
            COLS = ["thmName", "goalStr", "tactic", "status", "errmsg", "timeElapsed"]
            if line.startswith(TACBENCH_PREAMBLE):
                line = line.removeprefix(TACBENCH_PREAMBLE)
                row = line.split(", ")
                assert len(row) == len(COLS)
                record = dict(zip(COLS, row))
                record["fileTitle"] = fileTitle
                # TODO: invoke sqlite here to store
                logging.info(f"{fileTitle}: Opening connection to write test record.")
                con = sqlite3.connect(args.db)
                logging.info(f"{fileTitle}: Executing INSERT of record...")
                cur = con.cursor()
                cur.execute("""
                    INSERT INTO tests (
                        fileTitle,
                        thmName,
                        goalStr,
                        tactic,
                        status,
                        errmsg,
                        timeElapsed)
                    VALUES (?, ?, ?, ?, ?, ?, ?)
                """, (record["fileTitle"], record["thmName"], record["goalStr"], record["tactic"], record["status"], record["errmsg"], record["timeElapsed"]))
                con.commit()
                logging.info(f"{fileTitle}: Done executing INSERT of record...")
                con.close()

        # write that we are done with the file
        logging.info(f"{fileTitle}: Opening connection to write successful completion.")
        con = sqlite3.connect(args.db)
        logging.info(f"{fileTitle}: Executing INSERT of successful completion...")
        cur = con.cursor()
        cur.execute("""
            INSERT INTO completedFiles (fileTitle) VALUES (?)
        """, (record["fileTitle"], ))
        con.commit()
        logging.info(f"{fileTitle}: Done executing INSERT of successful completion...")
        con.close()

    except subprocess.TimeoutExpired as e:
        logging.info(f"{file_path} - time out of {TIMEOUT} seconds reached")
    finally:
        return

def process(db : str, jobs: int, prod_run : bool):
    tactic_auto_path = f'{ROOT_DIR}/SSA/Projects/InstCombine/TacticAuto.lean'

    # make a table.
    con = sqlite3.connect(db)
    cur = con.cursor()
    cur.execute("""
        CREATE TABLE IF NOT EXISTS tests (
            fileTitle text,
            thmName text,
            goalStr text,
            tactic text,
            status text,
            errmsg TEXT,
            timeElapsed FLOAT,
            PRIMARY KEY (fileTitle, thmName, goalStr, tactic)
            )
    """)
    cur.execute("""
        CREATE TABLE IF NOT EXISTS completedFiles (
            fileTitle text
            )
    """)

    con.commit()
    con.close()

    logging.info(f"Clearing git state of '{BENCHMARK_DIR}' with 'git checkout --'")
    gco = subprocess.Popen(f'git checkout -- {BENCHMARK_DIR}', cwd=ROOT_DIR, shell=True)
    gco.wait()
    assert gco.returncode == 0, f"git checkout -- {BENCHMARK_DIR} should succeed."


    logging.info(f"Running a 'lake exe cache get && lake build'.")
    lake = subprocess.Popen(f'lake exe cache get && lake build', cwd=ROOT_DIR, shell=True)
    lake.wait()
    assert lake.returncode == 0, f"lake build should succeed before running evaluation."

    with concurrent.futures.ThreadPoolExecutor(max_workers=jobs) as executor:
        futures = {}
        files = os.listdir(BENCHMARK_DIR)

        for file in files:
            if "_proof" in file and "gandhorhicmps_proof" not in file: # currently discard broken chapter
                future = executor.submit(run_file, db, file)
                futures[future] = file
                N_TEST_RUN_FILES = 5
                if len(futures) == N_TEST_RUN_FILES and not prod_run:
                    break # quit if we are not doing a production run after 5 files.

        total = len(futures)
        for idx, future in enumerate(concurrent.futures.as_completed(futures)):
            if future.exception() is not None:
                raise future.exception()
            file = futures[future]
            future.result()
            percentage = ((idx + 1) / total) * 100
            logging.info(f'{file} completed, {percentage}%')

def setup_logging(db_name : str):
    # Set up the logging configuration
    logging.basicConfig(level=logging.DEBUG,
        format='%(asctime)s - %(levelname)s - %(message)s',
        handlers=[logging.FileHandler(f'{db_name}.log', mode='a'), logging.StreamHandler()])

def analyze_errors(cur : sqlite3.Cursor):
    """Tabulate all uninterpreted functions"""
    logging.info("Analyzing uninterpreted functions")
    rows = cur.execute("""
        SELECT fileTitle, thmName, goalStr, errMsg FROM tests WHERE tactic = "circuit" AND status = "err"
    """)

    KEY_UNTRUE = "failed to prove goal  since decideIfZerosM established that theorem is not true"
    KEY_MULTIPLE_WIDTHS = "found multiple bitvector widths in the target"
    KEY_UNKNOWN_GOAL_STATE_FORMAT = "expected predicate over bitvectors (no quantification)  found"
    KEY_SYMBOLIC_SHIFT_LEFT = "expected shiftLeft by natural number  found symbolic shift amount"
    KEY_UNKNOWN_BOOLEAN_EQUALITY = "only boolean conditionals allowed are 'bv.slt bv = true'  'bv.sle bv = true'. Found"
    KEY_UNKNOWN_BOOLEAN_DISEQUALITY = "Expected typeclass to be 'BitVec w' / 'Nat'  found '   Bool' in"

    str2explanation = {
      KEY_UNTRUE : "theorems that are established as untrue",
      KEY_MULTIPLE_WIDTHS : "theorems that have multiple widths",
      KEY_UNKNOWN_GOAL_STATE_FORMAT : "theorems that have unknown goal state format",
      KEY_SYMBOLIC_SHIFT_LEFT : "theorems that have symbolic left shift amount",
      KEY_UNKNOWN_BOOLEAN_EQUALITY : "unknown boolean equality",
      KEY_UNKNOWN_BOOLEAN_DISEQUALITY : "unknown boolean disequality",
    }
    str2matches = {
      KEY_UNTRUE : [],
      KEY_MULTIPLE_WIDTHS : [],
      KEY_UNKNOWN_GOAL_STATE_FORMAT : [],
      KEY_SYMBOLIC_SHIFT_LEFT : [],
      KEY_UNKNOWN_BOOLEAN_EQUALITY : [],
      KEY_UNKNOWN_BOOLEAN_DISEQUALITY : [],
    }


    HEADERS = ["errMsg", "goalStr", "thmName", "fileTitle"]
    HEADER_COL_WIDTHS = [40, 40, 50, 50]
    for row in rows:
        (fileTitle, thmName, goalStr, errMsg) = row
        matched = False
        for s in str2matches:
            if s in errMsg:
                str2matches[s].append((errMsg, goalStr, thmName, fileTitle))
                matched = True
                break
        if not matched:
            print(errMsg)

    for s in str2matches:
        NEXAMPLES = 5
        print(f"{str2explanation[s]} (#{len(str2matches[s])}):")
        print(tabulate(str2matches[s][:NEXAMPLES], headers=HEADERS, tablefmt="grid", maxcolwidths=HEADER_COL_WIDTHS))


def analyze_uninterpreted_functions(cur : sqlite3.Cursor):
    """Tabulate all uninterpreted functions"""
    logging.info("Analyzing uninterpreted functions")
    rows = cur.execute("""
        SELECT fileTitle, thmName, goalStr, errMsg FROM tests WHERE tactic = "no_uninterpreted" AND status = "err"
    """)
    rows = list(rows)
    for row in rows:
        (fileTitle, thmName, goalStr, errMsg) = row
        print(errMsg)
    print(f"#problems with uninterpreted functions: {len(rows)}")

# analyze the sqlite db.
def analyze(db : str):
    con = sqlite3.connect(db)
    cur = con.cursor()
    analyze_uninterpreted_functions(cur)
    #analyze_errors(cur)
    pass


if __name__ == "__main__":
  current_time = datetime.datetime.now().strftime('%Y-%m-%d-%H:%M:%S')
  nproc = os.cpu_count()
  parser = argparse.ArgumentParser(prog='compare-automata-automata-circuit')
  default_db = f'automata-circuit-{current_time}.sqlite3'
  parser.add_argument('--db', default=default_db, help='path to sqlite3 database')
  parser.add_argument('-j', '--jobs', type=int, default=nproc // 3)
  parser.add_argument('--run', action='store_true', help="run evaluation")
  parser.add_argument('--prodrun', action='store_true', help="run production run of evaluation")
  parser.add_argument('--analyze', action='store_true', help="analyze the data of the db")
  args = parser.parse_args()
  setup_logging(args.db)
  logging.info(args)
  if args.run:
    process(args.db, args.jobs, prod_run=False)
  elif args.prodrun:
    process(args.db, args.jobs, prod_run=True)
  elif args.analyze:
    if args.db == default_db:
      logging.error("expected additional argument '--db <path/to/db/to/analyze'")
      exit(1)
    analyze(args.db)
  else:
    logging.error("expected --run or --prodrun.")

