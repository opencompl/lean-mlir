#!/usr/bin/env python3
import subprocess
import os
import platform
import concurrent.futures
import argparse
import shutil
import pandas as pd
import os
import re
import sqlite3

ROOT_DIR = subprocess.check_output(['git', 'rev-parse', '--show-toplevel']).decode('utf-8').strip()
RESULTS_DIR = ROOT_DIR + '/bv-evaluation/results/AutomataCircuit/'
BENCHMARK_DIR = ROOT_DIR + '/SSA/Projects/InstCombine/tests/proofs/'
REPS = 1
TIMEOUT = 1800 # timeout

def parse_tacbenches(file_name, raw):
    # Regular expression to match TACBENCH entries
    tac_bench_pattern = re.compile(
        r"TACBENCH\s+(\w+)\s+(PASS|FAIL),\s+TIME_ELAPSED\s+([\d.]+)\s+ms,(?:\s*MSGSTART(.*?)MSGEND)?",
        re.DOTALL
    )
    tac_block_pattern = re.compile(r"(TACSTART.*?TACEND)", re.DOTALL)
    # Parsing the TACBENCH entries
    guid = 0
    out = []
    for blk in tac_block_pattern.findall(raw):
        guid += 1
        new = []
        for match in tac_bench_pattern.finditer(blk):
            tactic_name = match.group(1)
            status = match.group(2)
            time_elapsed = float(match.group(3))
            error_message = match.group(4).strip() if match.group(4) else None  # Only if MSGSTART-MSGEND present
            new.append({
                "filename" : file_name,
                "guid":guid,
                "name": tactic_name,
                "status": status,
                "time_elapsed": time_elapsed,
                "error_message": error_message
            })
        print("==")
        print(blk)
        print("--")
        for r in new: print(r)
        out.extend(new)
        print("==")
    return out


def clear_results_folder():
    os.makedirs(RESULTS_DIR, exist_ok=True)
    for file in os.listdir(RESULTS_DIR):
        file_path = os.path.join(RESULTS_DIR, file)
        try:
            if os.path.isfile(file_path) or os.path.islink(file_path):
                os.unlink(file_path)
            elif os.path.isdir(file_path):
                shutil.rmtree(file_path)
        except Exception as e:
            print('Failed to delete %s. Reason: %s' % (file_path, e))

def sed():
    if platform.system() == "Darwin":
        return "gsed"
    return "sed"

def run_file(file: str):
    file_path = BENCHMARK_DIR + file
    file_title = file.split('.')[0]
    print(f"processing '{file}'")
    subprocess.Popen(f'{sed()} -i -E \'s,simp_alive_benchmark,bv_bench_automata,g\' ' + file_path, cwd=ROOT_DIR, shell=True).wait()

    for r in range(REPS):
        log_file_path = RESULTS_DIR + file_title + '_' + 'r' + str(r) + '.txt'
        with open(log_file_path, 'w') as log_file:
            cmd = 'lake lean ' + file_path
            print(cmd)
            try:
                subprocess.Popen(cmd, cwd=ROOT_DIR, stdout=log_file, stderr=log_file, shell=True).wait(timeout=TIMEOUT)
            except subprocess.TimeoutExpired:
                log_file.truncate(0)
                log_file.write(f"time out of {TIMEOUT} seconds reached\nt")
                print(f"{file_path} - time out of {TIMEOUT} seconds reached")

    subprocess.Popen('sed -i -E \'s,bv_bench,simp_alive_benchmark,g\' ' + file_path, cwd=ROOT_DIR, shell=True).wait()

def process(jobs: int):
    os.makedirs(RESULTS_DIR, exist_ok=True)
    tactic_auto_path = f'{ROOT_DIR}/SSA/Projects/InstCombine/TacticAuto.lean'

    with concurrent.futures.ThreadPoolExecutor(max_workers=jobs) as executor:
        futures = {}
        for file in os.listdir(BENCHMARK_DIR):
            if "_proof" in file and "gandhorhicmps_proof" not in file: # currently discard broken chapter
                future = executor.submit(run_file, file)
                futures[future] = file

        total = len(futures)
        for idx, future in enumerate(concurrent.futures.as_completed(futures)):
            file = futures[future]
            future.result()
            percentage = ((idx + 1) / total) * 100
            print(f'{file} completed, {percentage}%')

def produce_csv():
    out = None
    os.makedirs(RESULTS_DIR, exist_ok=True)
    for file in os.listdir(BENCHMARK_DIR):
        with open(RESULTS_DIR+file.split(".")[0]+"_"+str("w")+"_r"+str("0")+".txt") as res_file:
                results = parse_tacbenches(file.split(".")[0], res_file.read())

        df = pd.DataFrame(results)
        print(df)
        if out is None:
            out = df
        else:
            out = pd.concat([out, df])

    print(out)
    out.to_csv(RESULTS_DIR + 'hackersDelightSymbolic.csv')

if __name__ == "__main__":
  parser = argparse.ArgumentParser(prog='compare-automata-automata-circuit')
  parser.add_argument('-j', '--jobs', type=int, default=1)
  parser.add_argument('--evaluate', action='store_true', help="run evaluation")
  parser.add_argument('--csv', action='store_true', help="run CSV")
  args = parser.parse_args()
  clear_results_folder()
  if args.evaluate:
    process(args.jobs)
  if args.csv:
    produce_csv()
