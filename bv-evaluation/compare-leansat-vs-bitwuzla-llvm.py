import subprocess
import os
import concurrent.futures
import argparse

ROOT_DIR = subprocess.check_output(['git', 'rev-parse', '--show-toplevel']).decode('utf-8').strip()

RESULTS_DIR = ROOT_DIR + '/bv-evaluation/results/llvm/'

BENCHMARK_DIR = ROOT_DIR + '/SSA/Projects/InstCombine/tests/proofs/'

REPS = 1

def run_file(file: str):
    file_path = BENCHMARK_DIR + file
    file_title = file.split('.')[0]
    subprocess.Popen('sed -i -E \'s,sorry,bv_compare\'\\\'\',g\' ' + file_path, cwd=ROOT_DIR, shell=True).wait()

    for r in range(REPS):
        log_file_path = RESULTS_DIR + file_title + '_' + 'r' + str(r) + '.txt'
        with open(log_file_path, 'w') as log_file:
            cmd = 'lake lean ' + file_path
            print(cmd)
            subprocess.Popen(cmd, cwd=ROOT_DIR, stdout=log_file, stderr=log_file, shell=True).wait()
    subprocess.Popen('sed -i -E \'s,bv_compare\'\\\'\',sorry,g\' ' + file_path, cwd=ROOT_DIR, shell=True).wait()

def process(jobs: int):
    os.makedirs(RESULTS_DIR, exist_ok=True)
    tactic_auto_path = f'{ROOT_DIR}/SSA/Projects/InstCombine/TacticAuto.lean'

    # import Leanwuzla and uncomment relevant line
    subprocess.Popen(f'sed -i -E \'s,-- import Leanwuzla,import Leanwuzla,g\' {tactic_auto_path}', cwd=ROOT_DIR, shell=True).wait()
    subprocess.Popen(f'sed -i -E \'s,-- bv_compare --,bv_compare --,g\' {tactic_auto_path}', cwd=ROOT_DIR, shell=True).wait()
    subprocess.Popen(f'sed -i -E \'s,bv_decide -- replace this with bv_compare to evaluate performance,-- bv_decide -- replace this with bv_compare to evaluate performance,g\' {tactic_auto_path}', cwd=ROOT_DIR, shell=True).wait()

    with concurrent.futures.ThreadPoolExecutor(max_workers=jobs) as executor:
        futures = {}
        for file in os.listdir(BENCHMARK_DIR):
            if "_proof" in file and "gshifthaddhinseltpoison_proof" in file: # currently discard broken chapter
                future = executor.submit(run_file, file)
                futures[future] = file

        total = len(futures)
        for idx, future in enumerate(concurrent.futures.as_completed(futures)):
            file = futures[future]
            future.result()
            percentage = ((idx + 1) / total) * 100
            print(f'{file} completed, {percentage}%')

    # revert the preamble
    subprocess.Popen(f'sed -i -E \'s,import Leanwuzla,-- import Leanwuzla,g\' {tactic_auto_path}', cwd=ROOT_DIR, shell=True).wait()
    subprocess.Popen(f'sed -i -E \'s,bv_compare --,-- bv_compare --,g\' {tactic_auto_path}', cwd=ROOT_DIR, shell=True).wait()
    subprocess.Popen(f'sed -i -E \'s,-- bv_decide -- replace this with bv_compare to evaluate performance,bv_decide -- replace this with bv_compare to evaluate performance,g\' {tactic_auto_path}', cwd=ROOT_DIR, shell=True).wait()

parser = argparse.ArgumentParser(prog='compare-leansat-vs-bitwuzla-llvm')
parser.add_argument('-j', '--jobs', type=int, default=1)
args = parser.parse_args()
process(args.jobs)
