#!/usr/bin/env python3
# 30 sec * 2500 =
# >>> ((30 * 2500) / 60) / 60
# 20.833333333333332 / $NPROC
# maxHeartbeats
# timeout.
from typing import List, Dict, Optional
import os
import threading
import psutil
import time
import argparse
import glob
import sqlite3
import subprocess
import asyncio
import pathlib
import datetime
import logging


STATUS_FAIL = "fail"
STATUS_SUCCESS = "success"
STATUS_TIMED_OUT = "timeout"
STATUS_MEMORY_OUT = "memoryout"

status_to_emoji = {
    STATUS_FAIL : "❌",
    STATUS_SUCCESS : "🎉",
    STATUS_TIMED_OUT : "⌛️",
    STATUS_MEMORY_OUT : "💥"
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

def kill_process_tree(pid : int):
    """Kill process tree of PID"""
    try:
        parent = psutil.Process(pid)
        for child in parent.children(recursive=True):
            child.kill()
        parent.kill()
    except psutil.NoSuchProcess:
        pass


def monitor_memory(pid, memout_mb, flag):
    """
    monitor the memory of process 'pid', and update the 'flag'
    dictionary with 'memout=true' if we run out of memory
    """

    try:
        proc = psutil.Process(pid)
        while not flag["done"]:
            mem = proc.memory_info().rss
            for child in proc.children(recursive=True):
                try:
                    mem += child.memory_info().rss
                except psutil.NoSuchProcess:
                    continue
            if mem > memout_mb * 1024 * 1024:
                flag["memout"] = True
                kill_process_tree(pid)
                return
            time.sleep(1)
    except psutil.NoSuchProcess:
        pass


class RunWithLimitsResult:
    statuses = [STATUS_SUCCESS, STATUS_TIMED_OUT, STATUS_MEMORY_OUT, STATUS_FAIL]
    status : str
    returncode : Optional[int]
    stdout : str
    stderr : str

    def __init__(self, status : str, returncode : int, stdout : str, stderr : str):
        self.status = status
        self.returncode = returncode
        self.stdout = stdout
        self.stderr = stderr
        assert self.status in RunWithLimitsResult.statuses

def run_with_limits(cmd : list[str], timeout_sec : int, memout_mb : int) -> RunWithLimitsResult:
    """
    Run process 'cmd' with limits of 'timout' in seconds and 'memout' in megabyte.
    """
    try:
        proc = subprocess.Popen(
            cmd,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
            preexec_fn=os.setsid,
        )
        flag = {"done": False, "memout": False}
        monitor_thread = threading.Thread(
            target=monitor_memory, args=(proc.pid, memout_mb, flag)
        )
        monitor_thread.start()

        try:
            stdout, stderr = proc.communicate(timeout=timeout_sec)
            flag["done"] = True
            monitor_thread.join()
            if flag["memout"]:
                return RunWithLimitsResult(status=STATUS_MEMORY_OUT, returncode=None, stdout=stdout, stderr=stderr)
            return RunWithLimitsResult(status=STATUS_SUCCESS, returncode=proc.returncode, stdout=stdout, stderr=stderr)
        except subprocess.TimeoutExpired:
            flag["done"] = True
            kill_process_tree(proc.pid)
            stdout, stderr = proc.communicate()
            monitor_thread.join()
            return RunWithLimitsResult(status=STATUS_TIMED_OUT, returncode=None, stdout=stdout, stderr=stderr)
    except Exception as e:
        raise e
        return RunWithLimitsResult(status=STATUS_FAIL, returncode=None, stdout="", stderr="")


async def run_lake_build(db, git_root_dir, semaphore, timeout, memout_mb, i_test, n_tests, filename, completed_counter : Counter, test_content, solver):
    async with semaphore:
        module_name = pathlib.Path(filename).stem
        command = ["lake", "lean", filename, "--dir", git_root_dir]
        logging.info(f"Running {i_test+1}/{n_tests} '{" ".join(command)}'")

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
        result = run_with_limits(command, timeout_sec=timeout, memout_mb=memout_mb)
        exit_code = result.returncode
        walltime = float('inf')
        stdout = result.stdout
        status = result.status
        records = parse_tacbench_rows_from_stdout(filename, stdout)
        print(status)
        if len(records) != 1:
            logging.error(f"[{status} {status_to_emoji[status]} Error in {filename}]: found {len(records)} records, expected exactly one record.")
        else:
            record = records[0]
            walltime = record.walltime

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

    command = ["find", "/tmp/", "-type", "f", "-readable", "-name", "tmp.XX*", "-mmin", "+1", "-delete"]
    logging.info(f"{i_test+1}/{n_tests} Clearing /tmp/ folder with command '{" ".join(command)}'")
    result = subprocess.run(command, capture_output=True, text=True)
    # v This is OK. There will be files in '/tmp/ that are written by 'root',
    # but we don't care about clearing them, even if 'find' complains about
    # trying to open them.
    # if result.returncode != 0:
    #     logging.warning(f"{i_test+1}/{n_tests} failed to clear /tmp/: '{result.stderr}'")

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
import SSA.Experimental.Bits.Frontend.Tactic
import SSA.Experimental.Bits.Fast.MBA
import SSA.Core.Tactic.TacBench

set_option maxHeartbeats 0
set_option maxRecDepth 9000

/-
This dataset was derived from
https://github.com/softsec-unh/MBA-Blast/blob/main/dataset/dataset2_64bit.txt
-/

variable { a b c d e f g t x y z : BitVec 64 }
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
    solver_kinduction_verified = "kinduction_verified"
    solver_bv_automata_classic = "bv_automata_classic"
    solver_bv_decide = "bv_decide"
    solvers = [solver_mba, solver_bv_decide, solver_bv_automata_classic, solver_kinduction_verified]
    solver_num_problems = {
      solver_mba: 2500,
      solver_bv_automata_classic: 2500,
      solver_bv_decide: 2500,
      solver_kinduction_verified: 1500
    }

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
        elif solver == UnitTest.solver_kinduction_verified:
            return interpolant.format(solver=solver, call="bv_automata_gen (config := {backend := .circuit_cadical_verified 100 })")
        elif solver == UnitTest.solver_bv_automata_classic:
            return interpolant.format(solver=solver, call="bv_automata_gen (config := {backend := .automata })")
        elif solver == UnitTest.solver_bv_decide:
            return interpolant.format(solver=solver, call="bv_decide")
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

    tests = tests[::-1]

    out = []
    for s in UnitTest.solvers:
        for (ix, t) in enumerate(tests):
            if ix < int(getattr(args, s)): # UnitTest.solver_num_problems[s]:
                out.append(UnitTest(ix=ix, test=t, solver=s))
    out = out[::-1]
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
        for (i_test, test) in enumerate(tests):
            filename = f"Test{test.solver}{test.ix+1}.lean".replace("-","").replace("_","")
            with open(filename, 'w') as f:
                test.write(f)
            logging.debug(f"spawning async task for {test.ix+1}:{test.test.strip()}:{filename}")
            tg.create_task(run_lake_build(db=args.db,
                           git_root_dir=git_root_dir,
                           semaphore=semaphore,
                           timeout=args.timeout,
                           memout_mb=args.memout_mb,
                           i_test=i_test,
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

def parse_args():
    current_time = datetime.datetime.now().strftime('%Y-%m-%d-%H:%M:%S')
    parser = argparse.ArgumentParser(prog='runner')
    nproc = os.cpu_count()
    parser.add_argument('--db', default=f'run-{current_time}.sqlite3', help='path to sqlite3 database')
    # parser.add_argument('--prod-run', default=False, action='store_true', help='run a production run of the whole thing.')
    # parser.add_argument('--num-tests', type=int, default=100, help='number of tests to run')
    for solver in UnitTest.solvers:
        parser.add_argument("--" + solver, type=int, default=UnitTest.solver_num_problems[solver], help=f'run {solver} with these many problems, default {UnitTest.solver_num_problems[solver]}')
    parser.add_argument('-j', type=int, default=5, help='number of parallel jobs.')
    parser.add_argument('--timeout', type=int, default=60, help='number of seconds for timeout of test.')
    parser.add_argument('--memout-mb', type=int, default=8000, help='maximum memory usage per problem (in MB)')
    return parser.parse_args()

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
