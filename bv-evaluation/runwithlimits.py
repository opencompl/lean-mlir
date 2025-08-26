#!/usr/bin/env python3
import os
import subprocess
import shutil
import multiprocessing
import psutil
import time
import threading
from typing import List, Dict

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


def monitor_memory(pid: int, memout_mb: int, flag: Dict[str, str]):
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
            time.sleep(5)
    except psutil.NoSuchProcess:
        pass


def run_with_limits(cmd: List[str], timeout: int, memout_mb: int) -> (str, str, str):
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



