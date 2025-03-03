#!/usr/bin/env python3
# 30 sec * 2500 =
# >>> ((30 * 2500) / 60) / 60
# 20.833333333333332 / $NPROC
# maxHeartbeats
# timeout.
from typing import List, Dict
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

EMOJI_SKIP = "⏭️"
EMOJI_PLAY = "▶️"

status_to_emoji = {
    STATUS_FAIL : "❌",
    STATUS_SUCCESS : "🎉",
    STATUS_TIMED_OUT : "⌛️"
}

class Counter:
    def __init__(self, on_increment):
        self.val = 0
        self.on_increment = on_increment

    def increment(self):
        self.val += 1
        self.on_increment(self.val)

async def run_lake_build(db, git_root_dir, semaphore, timeout, i_test, n_tests, filename, completed_counter, test_content):
    async with semaphore:
        module_name = pathlib.Path(filename).stem
        command = f"lake build SSA.Experimental.Bits.Fast.Dataset2.{module_name}"
        logging.info(f"Running {i_test+1}/{n_tests} '{command}'")

        logging.info(f"[Looking up cached {filename}]  Opening connection...")
        con = sqlite3.connect(db)
        cur = con.cursor()
        # Check if there is a row with the given filename and timeout
        logging.info(f"[Looking up cached {filename}]  SELECTING for existing data...")
        cur.execute("""
            SELECT 1 FROM completed WHERE filename = ? LIMIT 1
        """, (filename, ))
        # Fetch the result, if no rows exist, the result will be an empty list
        result = cur.fetchone()
        con.close()

        # Return True if no row is found (i.e., result is None)
        logging.info(f"[Looking up cached {filename}]  DONE (cached: {result is not None})")
        if result is not None:
            logging.warning(f"Skipping ({filename}, {timeout}) as run already exists {EMOJI_SKIP}.")
            completed_counter.increment()
            return

        logging.info(f"Running {filename}, no cache found {EMOJI_PLAY}.")
        process = await asyncio.create_subprocess_exec(
            "lake",
            "build",
            f"SSA.Experimental.Bits.Fast.Dataset2.{module_name}",
            cwd=git_root_dir,
            stdout=asyncio.subprocess.PIPE,
            stderr=asyncio.subprocess.DEVNULL,
            preexec_fn=os.setsid,
        )

        status = STATUS_TIMED_OUT
        out = ""
        exit_code = 1
        try:
            stdout = await asyncio.wait_for(process.communicate(), timeout=timeout)
            exit_code = process.returncode
            status = STATUS_SUCCESS if process.returncode == 0 else STATUS_FAIL
        except asyncio.TimeoutError:
            logging.warning(f"[Timeout for {filename}] Process exceeded {timeout} seconds")
            os.killpg(os.getpgid(process.pid), 9) # kill the process and all its children
            try:
                os.killpg(os.getpgid(process.pid), 9) # kill the process and all its children
            except Exception as e:
                logging.warning(f"Weird exception {e}")

        logging.info(f"[Finished {filename}]  Status: {status} {status_to_emoji[status]}")

        for line in out.strip().split("\n"):
            TACBENCH_PREAMBLE = "TACBENCHCSV|"
            COLS = ["thm", "goal", "tactic", "status", "errmsg", "walltime"]
            if line.startswith(TACBENCH_PREAMBLE):
                line = line.removeprefix(TACBENCH_PREAMBLE)
                row = line.split(", ")
                assert len(row) == len(COLS)
                record = dict(zip(COLS, row))
                record["filename"] = filename
                # TODO: invoke sqlite here to store
                logging.info(f"{filename}: Opening connection to write test record.")
                con = sqlite3.connect(args.db)
                logging.info(f"{filename}: Executing INSERT of record...")
                cur = con.cursor()
                cur.execute("""
                    INSERT INTO tests (
                        filename,
                        thm,
                        goal,
                        tactic,
                        status,
                        errmsg,
                        walltime)
                    VALUES (?, ?, ?, ?, ?, ?, ?)
                """, (record["filename"], record["thm"], record["goal"], record["tactic"], record["status"], record["errmsg"], record["walltime"]))
                con.commit()
                logging.info(f"{filename}: Done executing INSERT of record...")
                con.close()

        # write that we are done with the file
        logging.info(f"{filename}: Opening connection to write successful completion.")
        con = sqlite3.connect(args.db)
        logging.info(f"{filename}: Executing INSERT of successful completion...")
        cur = con.cursor()
        cur.execute("""
            INSERT INTO completed (filename) VALUES (?)
        """, (filename, ))
        con.commit()
        logging.info(f"{filename}: Done executing INSERT of successful completion...")
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
import SSA.Core.Tactic.TacBench
import SSA.Experimental.Bits.Fast.MBA
import SSA.Experimental.Bits.Fast.Reflect
import SSA.Experimental.Bits.FastCopy.Reflect
import SSA.Experimental.Bits.AutoStructs.Tactic
import SSA.Experimental.Bits.AutoStructs.ForLean

set_option maxHeartbeats 0
set_option maxRecDepth 9000

/-
This dataset was derived from
https://github.com/softsec-unh/MBA-Blast/blob/main/dataset/dataset2_64bit.txt
-/

macro "run_bench" : tactic =>
  `(tactic| tac_bench (config := { outputType := .csv }) [
    "bv_mba" : bv_mba,
    "bv_automata_circuit" : bv_automata_circuit (config := {backend := .cadical }),
    "bv_automata_classic" : bv_automata_classic_nf, 
  ])

variable { a b c d e f g t x y z : BitVec w }
"""


def translate_dataset_expr_to_lean(counter, expression, rhs_after_colon_equals):

  return exp

def setup_logging(db_name : str):
    # Set up the logging configuration
    logging.basicConfig(level=logging.DEBUG,
        format='%(asctime)s - %(levelname)s - %(message)s',
        handlers=[logging.FileHandler(f'{db_name}.log', mode='a'), logging.StreamHandler()])


class UnitTest:
    test : str
    
    def __init__(self, test):
        self.test = test
    
    def write(self, f):
        f.write(test_file_preamble())
        out = f"private theorem thm :\n    "
        expression = self.test
        expression = expression.replace(",True", "")
        expression = expression.replace(",", " = ")
        expression = expression.replace("*", " * ")
        expression = expression.replace("-", " - ")
        expression = expression.replace("+", " + ")
        expression = expression.replace("^", " ^^^ ")
        expression = expression.replace("|", " ||| ")
        expression = expression.replace("&", " &&& ")
        expression = expression.replace("~", " ~~~")
        out = out + expression + " := by run_bench; sorry"
        f.write(out)

def load_tests(args) -> List[UnitTest]:
    with open('dataset2_64bit.txt', 'r') as f:
        tests = list(f)[1:]

    if not args.prod_run:
        logging.info(f"--prod_run not enabled, pruning files to small batch")
        tests = tests[:13]

    out = []
    for t in tests:
        out.append(UnitTest(test=t))
    return out


async def main(args):
    logging.info(f"parsed config args: {args}")

    git_root_dir = get_git_root()
    logging.info(f"project root dir is: {git_root_dir}")

    con = sqlite3.connect(args.db)
    cur = con.cursor()
    cur.execute("""
        CREATE TABLE IF NOT EXISTS tests (
            filename text,
            thm text,
            goal text,
            tactic text,
            status text,
            errmsg TEXT,
            walltime FLOAT,
            PRIMARY KEY (filename, thm, goal, tactic)
            )
    """)
    cur.execute("""
        CREATE TABLE IF NOT EXISTS completed (
            filename text
            )
    """)
    con.commit()
    con.close()

    semaphore = asyncio.Semaphore(args.j)  # Limit to j concurrent tasks

    tests = load_tests(args)
    n_tests = len(tests)
    logging.info(f"found {n_tests} files to process")
    completed_counter = Counter(lambda val: logging.info(f"** COMPLETED {val}/{n_tests} **"))

    async with asyncio.TaskGroup() as tg:
        for (i_test, test) in enumerate(tests):
            filename = f"Test{i_test+1}.lean".replace("-","").replace("_","")
            with open(filename, 'w') as f:
                test.write(f)
            logging.debug(f"spawning async task for {i_test+1}:{test.test.strip()}:{filename}")
            tg.create_task(run_lake_build(db=args.db,
                           git_root_dir=git_root_dir,
                           semaphore=semaphore,
                           timeout=args.timeout,
                           i_test=i_test,
                           n_tests=n_tests,
                           test_content=test.test,
                           filename=filename,
                           completed_counter=completed_counter))

# def print_summary_from_db(db):
#     logging.info(f"Summary of run:")
#     con = sqlite3.connect(db)
#     cur = con.cursor()
#     # Check if there is a row with the given filename and timeout
#     cur.execute("""
#         SELECT status, count(status) FROM tests GROUP BY status
#     """)
#     # Fetch the result, if no rows exist, the result will be an empty list
#     for row in cur.fetchall():
#       logging.info(f"  - {row[0]} : #{row[1]}")
# 
#     cur.execute("""
#         SELECT filename FROM tests  WHERE status == 'fail' ORDER BY filename ASC LIMIT 10
#     """)
#     rows = cur.fetchall()
#     if rows:
#       logging.info(f"{len(rows)} failing tests:")
#       for row in rows:
#           print(f"  - {row[0]}")
#     else:
#         logging.info("All tests passed!")
#     logging.info("Done with summary.")
#     con.close()

if __name__ == "__main__":
    args = parse_args()
    setup_logging(args.db)
    logging.debug("started asyncio")
    loop = asyncio.new_event_loop();
    asyncio.set_event_loop(loop);
    loop.run_until_complete(main(args))
    # https://stackoverflow.com/questions/65682221/runtimeerror-exception-ignored-in-function-proactorbasepipetransport
    # asyncio.run(main(args), debug=True)
    logging.debug("done asyncio")
    # print_summary_from_db(args.db)
    logging.info(f"completed run {args}")
