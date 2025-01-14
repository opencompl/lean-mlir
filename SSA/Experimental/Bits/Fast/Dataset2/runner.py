#!/usr/bin/env python3
# 30 sec * 2500 = 
# >>> ((30 * 2500) / 60) / 60
# 20.833333333333332 / $NPROC
# maxHeartbeats
# timeout.
import os
import argparse
import glob
import sqlite3
import subprocess
import asyncio
import pathlib
import datetime
import logging

def parse_args():
    current_time = datetime.datetime.now().strftime('%Y-%m-%d-%H:%M:%S')
    parser = argparse.ArgumentParser(prog='runner')
    nproc = os.cpu_count()
    parser.add_argument('--db', default=f'run-{current_time}.sqlite3', help='path to sqlite3 database')
    parser.add_argument('--prod-run', default=False, action='store_true', help='run a production run of the whole thing.')
    parser.add_argument('-j', type=int, default=nproc, help='number of parallel jobs.')
    parser.add_argument('--timeout', type=int, default=60, help='number of seconds for timeout of test.')
    return parser.parse_args()

STATUS_FAIL = "fail"
STATUS_SUCCESS = "success"
STATUS_TIMED_OUT = "timeout"

async def run_lake_build(db, git_root_dir, semaphore, timeout, i_test, n_tests, filename):
    async with semaphore:
        module_name = pathlib.Path(filename).stem
        command = f"lake build SSA.Experimental.Bits.Fast.Dataset2.{module_name}"
        logging.info(f"Running {i_test+1}/{n_tests} '{command}'")

        con = sqlite3.connect(db)
        cur = con.cursor()
        # Check if there is a row with the given filename and timeout
        cur.execute("""
            SELECT 1 FROM tests WHERE filename = ? AND timeout = ? LIMIT 1
        """, (filename, timeout))
        # Fetch the result, if no rows exist, the result will be an empty list
        result = cur.fetchone()
        con.close()

        # Return True if no row is found (i.e., result is None)
        if result is not None:
            logging.warning(f"Skipping ({filename}, {timeout}) as run already exists.")
            return
        
        process = await asyncio.create_subprocess_shell(
            command,
            cwd=git_root_dir,
            stdout=asyncio.subprocess.PIPE,
            stderr=asyncio.subprocess.PIPE
        )
        stdout_task = asyncio.create_task(process.stdout.read())
        stderr_task = asyncio.create_task(process.stderr.read())
    
        stdout = ""
        stderr = ""
        status = STATUS_TIMED_OUT
        exit_code = 1

        try:
            await asyncio.wait_for(process.wait(), timeout=timeout)
            exit_code = process.returncode
            stdout, stderr = await asyncio.gather(stdout_task, stderr_task)
            status = STATUS_SUCCESS if process.returncode == 0 else STATUS_FAIL
        except asyncio.TimeoutError:
            logging.warning(f"[Timeout for {filename}] Process exceeded {timeout} seconds")
            # Create a task to read stdout and stderr concurrently
            # Capture whatever was output before the timeout
            process.kill()  # Terminate the process
            await process.wait()  # Ensure cleanup
            stdout, stderr = await asyncio.gather(stdout_task, stderr_task)

        if stdout:
            logging.debug(f"[Output for {filename}]\n{stdout.decode()}")
        if stderr:
            logging.debug(f"[Error for {filename}]\n{stderr.decode()}")

        logging.info(f"[Finished {filename}]  Status: {status}")

        con = sqlite3.connect(args.db)
        cur = con.cursor()
        cur.execute("""
            INSERT INTO tests (
                filename,
                timeout,
                status,
                stdout,
                stderr,
                exit_code)
            VALUES (?, ?, ?, ?, ?, ?)
        """, (filename, timeout, status, stdout, stderr, exit_code))
        con.commit()
        con.close()

def get_git_root():
    result = subprocess.run(
        ["git", "rev-parse", "--show-toplevel"],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE
    )
    return result.stdout.decode().strip()


def test_file_preamble():
    return """
import Std.Tactic.BVDecide
import SSA.Experimental.Bits.Fast.Reflect

set_option maxHeartbeats 0

/-
This dataset was derived from
https://github.com/softsec-unh/MBA-Blast/blob/main/dataset/dataset2_64bit.txt
-/
"""

def translate_dataset_expr_to_lean(counter, expression):
  exp = f"theorem e_{counter} (x y : BitVec w) :\n    "
  expression = expression.replace(",True", "")
  expression = expression.replace(",", " = ")
  expression = expression.replace("*", " * ")
  expression = expression.replace("-", " - ")
  expression = expression.replace("+", " + ")
  expression = expression.replace("^", " ^^^ ")
  expression = expression.replace("|", " ||| ")
  expression = expression.replace("&", " &&& ")
  expression = expression.replace("~", " ~~~")

  exp = exp + expression + " := by\n  bv_automata_circuit (config := { backend := .cadical })\n"

  return exp

def write_files():
    counter = 0
    with open('dataset2_64bit.txt', 'r') as infile:
        for line in list(infile)[1:]:
            with open(f'Test{counter}.lean', 'w') as outfile:
                outfile.write(preamble)
                outfile.write(translate_dataset_expr_to_lean(counter, line.strip()) + "\n")
            counter += 1

def setup_logging(db_name : str):
    # Set up the logging configuration
    logging.basicConfig(level=logging.DEBUG, 
        format='%(asctime)s - %(levelname)s - %(message)s',
        handlers=[logging.FileHandler(f'{db_name}.log', mode='a'), logging.StreamHandler()])

async def main(args):
    setup_logging(args.db)
    logging.info(f"parsed config args: {args}")

    git_root_dir = get_git_root()
    logging.info(f"project root dir is: {git_root_dir}")

    con = sqlite3.connect(args.db)
    cur = con.cursor()
    cur.execute("""
        CREATE TABLE IF NOT EXISTS tests (
            filename TEXT,
            timeout INTEGER,
            status TEXT,
            stdout TEXT, 
            stderr TEXT,
            exit_code INTEGER,
            PRIMARY KEY (filename, timeout)  -- Composite primary key
            )
    """)
    con.commit()
    con.close()

    semaphore = asyncio.Semaphore(args.j)  # Limit to j concurrent tasks

    # Get all files matching the pattern

    with open('dataset2_64bit.txt', 'r') as f:
        tests = list(f)[1:]

    if not args.prod_run:
        logging.info(f"--prod_run not enabled, pruning files to small batch")
        tests = tests[:20]
    n_tests = len(tests)

    logging.info(f"found {n_tests} files to process")
    async with asyncio.TaskGroup() as tg:
        for (i_test, test) in enumerate(tests):
            filename = f"Test{i_test+1}.lean"
            with open(filename, 'w') as f:
                f.write(test_file_preamble())
                f.write(translate_dataset_expr_to_lean(i_test, test.strip()) + "\n")

            logging.debug(f"spawning async task for {i_test+1}:{test.strip()}:{filename}")
            tg.create_task(run_lake_build(db=args.db,
                           git_root_dir=git_root_dir,
                           semaphore=semaphore,
                           timeout=args.timeout,
                           i_test=i_test,
                           n_tests=n_tests,
                           filename=filename))

if __name__ == "__main__":
    args = parse_args()
    asyncio.run(main(args))
