#!/usr/bin/env -S uv run
import os
import subprocess
import psutil
import time
import threading
import argparse
import sys
from typing import List, Dict, Optional

def kill_process_tree(pid: int):
    """
    Kill the entire process tree owned by 'pid'
    """
    try:
        parent = psutil.Process(pid)
        for child in parent.children(recursive=True):
            child.kill()
        parent.kill()
    except psutil.NoSuchProcess:
        pass


def monitor_memory(pid: int, memout_mb: int, flag: Dict[str, bool]):
    """
    Monitor memory of process 'pid', and ensure that it
    does not exceed 'memout_mb' (in megabytes) by polling.
    'flag' is an inout dict used for communication between
    the monitor thread and the main thread.
    - flag["done"]: whether the process has finished running
    - flag["memout"]: whether the process has exceeded memory limits.
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
            time.sleep(0.1)
    except psutil.NoSuchProcess:
        pass


def run_with_limits(cmd: List[str], timeout: int, memout_mb: int, cwd : Optional[str] = None) -> (str, str, str):
    """
    Run the process 'cmd' with timeout 'timeout' in seconds,
    and memout 'memout_mb' in megabyte.
    Note: this is a blocking, synchronous function.

    Returns:
    (error?, stdout, stderr)
    where error? can be:
    - "" if no error
    - "TIMEOUT" if process was killed due to timeout.
    - "MEMOUT" if process was killed due to memory out.
    - "ERROR" if an exception took place in running the command.
    """
    try:
        proc = subprocess.Popen(
            cmd,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
            preexec_fn=os.setsid,
            cwd=cwd
        )
        flag = {"done": False, "memout": False}
        monitor_thread = threading.Thread(
            target=monitor_memory, args=(proc.pid, memout_mb, flag)
        )
        monitor_thread.start()

        try:
            stdout, stderr = proc.communicate(timeout=timeout)
            flag["done"] = True
            monitor_thread.join()
            if flag["memout"]:
                return "MEMOUT", stdout, stderr
            return proc.returncode, stdout, stderr
        except subprocess.TimeoutExpired:
            flag["done"] = True
            kill_process_tree(proc.pid)
            stdout, stderr = proc.communicate()
            monitor_thread.join()
            return "TIMEOUT", stdout, stderr
    except Exception as e:
        return "ERROR", "", str(e)

class Errcode:
    TIMEOUT = 10
    MEMOUT = 20
    PYERROR = 30

def parse_args():
    parser = argparse.ArgumentParser(formatter_class=argparse.RawDescriptionHelpFormatter,
        description=(
        f"Run a command with timeout and memory limits.\n\n"
        f"RETURN CODES:\n"
        f"  success:      0\n"
        f"  timeout:      {Errcode.TIMEOUT}\n"
        f"  memout:       {Errcode.MEMOUT}\n"
        f"  python error: {Errcode.PYERROR}\n"
        ))
    parser.add_argument("--timeout-sec", type=int, required=True, help="Timeout in seconds")
    parser.add_argument("--memout-mb", type=int, required=True, help="Memory limit in MB")
    parser.add_argument("cmd", nargs=argparse.REMAINDER, help="Command to run with arguments")
    return parser.parse_args()

def main():
    args = parse_args()

    if args.cmd and args.cmd[0] == "--":
        cmd_args = args.cmd[1:]
    else:
        cmd_args = args.cmd

    err, stdout, stderr = run_with_limits(cmd_args, args.timeout_sec, args.memout_mb)
    print(stdout, file=sys.stdout, end="")
    print(stderr, file=sys.stderr, end="")

    if isinstance(err, int):
        sys.exit(err)
    elif err == "TIMEOUT":
        sys.exit(Errcode.TIMEOUT)
    elif err == "MEMOUT":
        sys.exit(Errcode.MEMOUT)
    else:
        sys.exit(Errcode.PYERROR)

if __name__ == "__main__":
    main()

