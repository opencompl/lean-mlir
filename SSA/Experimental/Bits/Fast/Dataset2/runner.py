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

class TacbenchRecord:
    TACBENCH_PREAMBLE = "TACBENCHCSV|"
    COLS = ["thm", "goal", "tactic", "status", "errmsg", "walltime"]
    def __init__(self, thm, goal, tactic, status, errmsg, walltime, filename):
        self.thm = thm
        self.goal = goal
        self.tactic = tactic
        self.status = status
        self.errmsg = errmsg
        self.walltime = walltime
        self.filename = filename


    @classmethod
    def is_tacbench_row(cls, line : str) -> bool:
        return line.startswith(TacbenchRecord.TACBENCH_PREAMBLE)
    @classmethod
    def parse_tacbench_row(cls, filename : str, line : str):
        assert line.startswith(TacbenchRecord.TACBENCH_PREAMBLE)
        line = line.removeprefix(TacbenchRecord.TACBENCH_PREAMBLE)
        row = line.split(", ")
        assert len(row) == len(TacbenchRecord.COLS)
        record = dict(zip(TacbenchRecord.COLS, row))
        record["filename"] = filename
        return TacbenchRecord(**record)

def parse_tacbench_rows_from_stdout(filename : str, stdout : str) -> List[TacbenchRecord]:
    rows = []
    for line in stdout.split("\n"):
        if TacbenchRecord.is_tacbench_row(line):
            rows.append(TacbenchRecord.parse_tacbench_row(filename, line))
    return rows

async def run_lake_build(db, git_root_dir, semaphore, timeout, i_test, n_tests, filename, completed_counter : Counter, test_content, solver):
    async with semaphore:
        module_name = pathlib.Path(filename).stem
        command = f"lake lean {filename} --dir {git_root_dir}"
        logging.info(f"Running {i_test+1}/{n_tests} '{command}'")

        logging.info(f"[Looking up cached {filename}]  Opening connection...")
        con = sqlite3.connect(db)
        cur = con.cursor()
        # Check if there is a row with the given filename and timeout
        logging.info(f"[Looking up cached {filename}]  SELECTING for existing data...")
        cur.execute("""
            SELECT 1 FROM tests WHERE filename = ? AND timeout = ? LIMIT 1
        """, (filename, timeout))
        # Fetch the result, if no rows exist, the result will be an empty list
        result = cur.fetchone()
        con.close()

        # Return True if no row is found (i.e., result is None)
        logging.info(f"[Looking up cached {filename}]  DONE (cached: {result is not None})")
        if result is not None:
            logging.warning(f"Skipping ({filename}, {timeout}) as run already exists.")
            completed_counter.increment()
            return

        logging.info(f"Running {filename}, no cache found.")
        process = await asyncio.create_subprocess_exec(
            "lake",
            "lean",
            filename,
            "--dir",
            git_root_dir,
            # cwd=git_root_dir,
            stdout=asyncio.subprocess.PIPE,
            stderr=asyncio.subprocess.DEVNULL,
            preexec_fn=os.setsid
        )

        status = STATUS_TIMED_OUT
        exit_code = 1
        walltime = float('inf')
        stdout = ""
        try:
            stdout, stderr = await asyncio.wait_for(process.communicate(), timeout=timeout)
            stdout = stdout.decode("utf-8")
            records = parse_tacbench_rows_from_stdout(filename, stdout)
            assert len(records) == 1
            record = records[0]
            walltime = record.walltime
            exit_code = process.returncode
            status = STATUS_SUCCESS if process.returncode == 0 else STATUS_FAIL
        except asyncio.TimeoutError:
            logging.warning(f"[Timeout for {filename}] Process exceeded {timeout} seconds")
            os.killpg(os.getpgid(process.pid), 9) # kill the process and all its children
            try:
                os.killpg(os.getpgid(process.pid), 9) # kill the process and all its children
            except Exception as e:
                logging.warning(f"Weird exception: {e}")

        logging.info(f"[Finished {filename}]  Status: {status} {status_to_emoji[status]}")

        logging.info(f"[Writing {filename}]  Opening connection...")
        con = sqlite3.connect(args.db)
        logging.info(f"[Writing {filename}]  Executing INSERT...")
        cur = con.cursor()
        cur.execute("""
            INSERT INTO tests (
                filename,
                test_content,
                solver,
                timeout,
                status,
                exit_code,
                walltime)
            VALUES (?, ?, ?, ?, ?, ?, ?)
        """, (filename, test_content, solver, timeout, status, exit_code, walltime))
        logging.info(f"[Writing {filename}]  Commiting...")
        con.commit()
        logging.info(f"[Writing {filename}]  Closing...")
        con.close()
        logging.info(f"[Writing {filename}]  DONE")
        completed_counter.increment()

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
-- import SSA.Experimental.Bits.AutoStructs.Tactic
-- import SSA.Experimental.Bits.AutoStructs.ForLean

set_option maxHeartbeats 0
set_option maxRecDepth 9000

/-
This dataset was derived from
https://github.com/softsec-unh/MBA-Blast/blob/main/dataset/dataset2_64bit.txt
-/

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
    ix : int
    test : str
    solver : str

    solver_mba = "mba"
    solver_kinduction = "kinduction"
    solver_bv_automata_classic = "bv_automata_classic"
    solvers = [solver_mba, solver_kinduction, solver_bv_automata_classic]
    
    def __init__(self, ix, test, solver):
        self.ix = ix
        self.test = test
        self.solver = solver
        assert self.solver in UnitTest.solvers

    @classmethod
    def _solver_to_tactic_invocation(cls, solver):
        interpolant = """by tac_bench (config := {{ outputType := .csv }}) ["{solver}" : {call}]; sorry"""
        if solver == UnitTest.solver_mba:
            return interpolant.format(solver=solver, call="bv_mba")
        elif solver == UnitTest.solver_kinduction:
            return interpolant.format(solver=solver, call="bv_automata_circuit (config := {backend := .cadical})")
        elif solver == UnitTest.solver_bv_automata_classic:
            return interpolant.format(solver=solver, call="bv_automata_classic_nf")
        else:
            raise RuntimeError(f"expected solver to be one of '{UnitTest.solvers}', found '{solver}'")
    
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
        out = out + expression + " := " + self._solver_to_tactic_invocation(self.solver)
        f.write(out)

def load_tests(args) -> List[UnitTest]:
    with open('dataset2_64bit.txt', 'r') as f:
        # sort tests backwards, from hardest to easiest!
        tests = list(f)[1:]

    out = []
    ix = 0
    for (ix, t) in enumerate(tests):
        for s in UnitTest.solvers:
            out.append(UnitTest(ix=ix, test=t, solver=s))

    if not args.prod_run:
        logging.info(f"--prod_run not enabled, pruning files to small batch")
        NTESTS_TO_RETURN = 1
        return out[-NTESTS_TO_RETURN*len(UnitTest.solvers):]
        # return out[:NTESTS_TO_RETURN*len(UnitTest.solvers)]
    else:
        return out


async def main(args):
    logging.info(f"parsed config args: {args}")

    git_root_dir = get_git_root()
    logging.info(f"project root dir is: {git_root_dir}")

    con = sqlite3.connect(args.db)
    cur = con.cursor()
    cur.execute("""
        CREATE TABLE IF NOT EXISTS tests (
            filename TEXT,
            test_content TEXT,
            solver TEXT,
            timeout INTEGER,
            status TEXT,
            exit_code INTEGER,
            walltime FLOAT,
            PRIMARY KEY (filename, timeout)  -- Composite primary key
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
        # work through tests in reverse order, hardest to easiest.
        for test in tests:
            filename = f"Test{test.solver}{test.ix+1}.lean".replace("-","").replace("_","")
            with open(filename, 'w') as f:
                test.write(f)
            logging.debug(f"spawning async task for {test.ix+1}:{test.test.strip()}:{filename}")
            tg.create_task(run_lake_build(db=args.db,
                           git_root_dir=git_root_dir,
                           semaphore=semaphore,
                           timeout=args.timeout,
                           i_test=test.ix,
                           n_tests=n_tests,
                           test_content=test.test,
                           solver=test.solver,
                           filename=filename,
                           completed_counter=completed_counter))

def print_summary_from_db(db):
    logging.info(f"Summary of run:")
    con = sqlite3.connect(db)
    cur = con.cursor()
    # Check if there is a row with the given filename and timeout
    cur.execute("""
        SELECT status, count(status) FROM tests GROUP BY status
    """)
    # Fetch the result, if no rows exist, the result will be an empty list
    for row in cur.fetchall():
      logging.info(f"  - {row[0]} : #{row[1]}")

    cur.execute("""
        SELECT filename FROM tests  WHERE status == 'fail' ORDER BY filename ASC LIMIT 10
    """)
    rows = cur.fetchall()
    if rows:
      logging.info(f"{len(rows)} failing tests:")
      for row in rows:
          print(f"  - {row[0]}")
    else:
        logging.info("All tests passed!")
    logging.info("Done with summary.")
    con.close()

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
    print_summary_from_db(args.db)
    logging.info(f"completed run {args}")
