import subprocess
import os
import concurrent.futures
import argparse
import shutil

ROOT_DIR = subprocess.check_output(['git', 'rev-parse', '--show-toplevel']).decode('utf-8').strip()

RESULTS_DIR = ROOT_DIR + "bv-evaluation/results/HackersDelight/"

BENCHMARK_DIR = ROOT_DIR + "SSA/Projects/InstCombine/HackersDelight/"

REPS = 1
TIMEOUT = 1800
bv_widths = [4, 8, 16, 32, 64]

def clear_folder():
    for file in os.listdir(RESULTS_DIR):
        file_path = os.path.join(RESULTS_DIR, file)
        try:
            if os.path.isfile(file_path) or os.path.islink(file_path):
                os.unlink(file_path)
            elif os.path.isdir(file_path):
                shutil.rmtree(file_path)
        except Exception as e:
            print(f'Failed to delete {file_path}. Reason: {e}')

def run_file(file_path: str, file_title: str, width: int):
    try:
        for r in range(REPS):
            log_file_path = os.path.join(RESULTS_DIR, f'{file_title}_{width}_r{r}.txt')
            with open(log_file_path, 'w') as log_file:
                cmd = f'lake lean {file_path}'
                print(cmd)
                try:
                    subprocess.Popen(cmd, cwd=ROOT_DIR, stdout=log_file, stderr=log_file, shell=True).wait(timeout=TIMEOUT)
                except subprocess.TimeoutExpired:
                    log_file.truncate(0)
                    log_file.write(f"time out of {TIMEOUT} seconds reached\n")
                    print(f"{file_path} - time out of {TIMEOUT} seconds reached")
    finally:
        if os.path.exists(file_path):
            os.remove(file_path)
            print(f"Deleted temporary file: {file_path}")

def process(jobs: int):
    os.makedirs(RESULTS_DIR, exist_ok=True)

    with concurrent.futures.ThreadPoolExecutor(max_workers=jobs) as executor:
        futures = {}
        for file in os.listdir(BENCHMARK_DIR):
            original_path = os.path.join(BENCHMARK_DIR, file)
            with open(original_path, 'r', encoding='utf-8') as f:
                original_content = f.read()
            updated_content = original_content.replace("sorry", "bv_compare'")
            file_base = os.path.splitext(file)[0]
            for width in bv_widths:
                modified_content = updated_content.replace("WIDTH", str(width))
                new_filename = f"{file_base}_{width}.lean"
                new_file_path = os.path.join(BENCHMARK_DIR, new_filename)
                with open(new_file_path, 'w', encoding='utf-8') as new_file:
                    new_file.write(modified_content)
                future = executor.submit(run_file, new_file_path, file_base, width)
                futures[future] = new_filename

        total = len(futures)
        for idx, future in enumerate(concurrent.futures.as_completed(futures)):
            file = futures[future]
            future.result()
            percentage = ((idx + 1) / total) * 100
            print(f'{file} completed, {percentage:.2f}%')

clear_folder()
parser = argparse.ArgumentParser(prog='compare-leansat-vs-bitwuzla-llvm')
parser.add_argument('-j', '--jobs', type=int, default=1)
args = parser.parse_args()
process(args.jobs)