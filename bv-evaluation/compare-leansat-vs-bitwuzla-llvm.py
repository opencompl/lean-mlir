import subprocess
import os
import concurrent.futures
import argparse
import shutil

ROOT_DIR = subprocess.check_output(['git', 'rev-parse', '--show-toplevel']).decode('utf-8').strip()

RESULTS_DIR = ROOT_DIR + '/bv-evaluation/results/InstCombine/'

BENCHMARK_DIR = ROOT_DIR + '/SSA/Projects/InstCombine/tests/proofs/'

REPS = 1 

TIMEOUT = 3600

def clear_folder():
    for file in os.listdir(RESULTS_DIR):
        file_path = os.path.join(RESULTS_DIR, file)
        try:
            if os.path.isfile(file_path) or os.path.islink(file_path):
                os.unlink(file_path)
            elif os.path.isdir(file_path):
                shutil.rmtree(file_path)
        except Exception as e:
            print('Failed to delete %s. Reason: %s' % (file_path, e))

def run_file(file: str):
    file_path = BENCHMARK_DIR + file
    file_title = file.split('.')[0]

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

def process(jobs: int):
    os.makedirs(RESULTS_DIR, exist_ok=True)
    tactic_auto_path = f'{ROOT_DIR}/SSA/Projects/InstCombine/TacticAuto.lean'

    with concurrent.futures.ThreadPoolExecutor(max_workers=jobs) as executor:
        futures = {}
        for file in os.listdir(BENCHMARK_DIR):
            if "_proof" in file: # currently discard broken chapter
                future = executor.submit(run_file, file)
                futures[future] = file

        total = len(futures)
        for idx, future in enumerate(concurrent.futures.as_completed(futures)):
            file = futures[future]
            future.result()
            percentage = ((idx + 1) / total) * 100
            print(f'{file} completed, {percentage}%')

parser = argparse.ArgumentParser(prog='compare-leansat-vs-bitwuzla-llvm')
parser.add_argument('-j', '--jobs', type=int, default=1)
args = parser.parse_args()
clear_folder()
process(args.jobs)
