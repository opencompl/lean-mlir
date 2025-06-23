#!/usr/bin/env python3
import argparse
import os
import subprocess
import concurrent.futures
import shutil

bv_widths = [4, 8, 16, 32, 64]

ROOT_DIR = subprocess.check_output(['git', 'rev-parse', '--show-toplevel']).decode('utf-8').strip()

RESULTS_DIR_ALIVE = ROOT_DIR + '/bv-evaluation/results/Alive/'
BENCHMARK_DIR_ALIVE = ROOT_DIR + '/SSA/Projects/InstCombine/'

RESULTS_DIR_HACKERSDELIGHT = ROOT_DIR + '/bv-evaluation/results/HackersDelight/'
BENCHMARK_DIR_HACKERSDELIGHT = ROOT_DIR + '/SSA/Projects/InstCombine/HackersDelight/'

RESULTS_DIR_INSTCOMBINE = ROOT_DIR + '/bv-evaluation/results/InstCombine/'
BENCHMARK_DIR_INSTCOMBINE = ROOT_DIR + '/SSA/Projects/InstCombine/tests/proofs/'

TIMEOUT = 1800

def clear_folder(results_dir):
    """Clears all files and subdirectories within the given directory."""
    if not os.path.exists(results_dir):
        return

    for item in os.listdir(results_dir):
        item_path = os.path.join(results_dir, item)
        try:
            if os.path.isfile(item_path) or os.path.islink(item_path):
                os.unlink(item_path)
            elif os.path.isdir(item_path):
                shutil.rmtree(item_path)
        except Exception as e:
            print(f'Failed to delete {item_path}. Reason: {e}')

def run_file(benchmark : str, file_to_run : str, log_file_base_name : str, hackersdelight_width: str = None) :
    """
    Runs a single Lean file and logs its output.
    file_to_run: The full path to the .lean file to execute.
    log_file_base_name: The base name for the log file.
    hackersdelight_width: Bitvector width for Hackers' delight problems.
    """
    cmd_prefix = 'lake lean '
    if benchmark == "hackersdelight":
        log_file_name = f'{log_file_base_name}_{hackersdelight_width}.txt'
        log_file_path = os.path.join(RESULTS_DIR_HACKERSDELIGHT, log_file_name)
    elif benchmark == "instcombine":
        log_file_path = os.path.join(RESULTS_DIR_INSTCOMBINE, f'{log_file_base_name}.txt')
    else : 
        raise Exception("Unknown benchmark.") 

    # Construct log file name including original file's base name and bit-width
    with open(log_file_path, 'w') as log_file:
        cmd = cmd_prefix + file_to_run
        print(f"Running: {cmd}")
        try:
            subprocess.Popen(cmd, cwd=ROOT_DIR, stdout=log_file, stderr=log_file, shell=True).wait(timeout=TIMEOUT)
        except subprocess.TimeoutExpired:
                    log_file.truncate(0)
                    log_file.write(f"time out of {TIMEOUT} seconds reached\n")
                    print(f"{file_to_run} - time out of {TIMEOUT} seconds reached")

    if (benchmark == "hackersdelight"):
        # Clean up the temporary file created for this specific bit-width and original file for hackersdelight
        if os.path.exists(file_to_run):
            os.remove(file_to_run)
            print(f"Deleted temporary file: {file_to_run}")

def compare(benchmark : str, jobs: int) :
    """Processes benchmarks using a thread pool."""
    with concurrent.futures.ThreadPoolExecutor(max_workers=jobs) as executor:
        futures = {}

        if benchmark == "hackersdelight":
            # Iterate through all .lean files in the HackersDelight directory
            clear_folder(RESULTS_DIR_HACKERSDELIGHT)
            os.makedirs(RESULTS_DIR_HACKERSDELIGHT, exist_ok=True)
            for original_file_name in os.listdir(BENCHMARK_DIR_HACKERSDELIGHT):
                if not original_file_name.endswith('.lean'):
                    continue # Skip non-Lean files

                original_file_path = os.path.join(BENCHMARK_DIR_HACKERSDELIGHT, original_file_name)
                # Read the content of the original template file
                with open(original_file_path, 'r', encoding='utf-8') as f:
                    original_content = f.read()

                # Get the base name of the original file (e.g., "my_template_file")
                original_file_base = os.path.splitext(original_file_name)[0]

                for width in bv_widths:
                    # Apply both replacements: 'sorry' to 'bv_compare'' and 'WIDTH' to actual width
                    modified_content = original_content.replace("sorry", "bv_compare'").replace("WIDTH", str(width))
                    
                    # Create a new temporary filename that includes original file's base name and width
                    temp_filename = f"{original_file_base}_{width}.lean"
                    temp_file_path = os.path.join(BENCHMARK_DIR_HACKERSDELIGHT, temp_filename)
                    
                    # Write the modified content to the temporary file
                    with open(temp_file_path, 'w', encoding='utf-8') as temp_file:
                        temp_file.write(modified_content)
                    
                    # Submit the temporary file to be run.
                    # log_file_base_name will be 'original_file_base'
                    # specific_arg_for_log_name will be the 'width'
                    future = executor.submit(run_file, "hackersdelight", temp_file_path, original_file_base, str(width))
                    futures[future] = temp_filename # Store the name of the temporary file for progress reporting

        elif benchmark == "instcombine":
            clear_folder(RESULTS_DIR_INSTCOMBINE)
            os.makedirs(RESULTS_DIR_INSTCOMBINE, exist_ok=True)

            for file in os.listdir(BENCHMARK_DIR_INSTCOMBINE):
                if "_proof" in file and file.endswith('.lean'): # Ensure it's a Lean file
                    file_path = os.path.join(BENCHMARK_DIR_INSTCOMBINE, file)
                    file_title = os.path.splitext(file)[0]
                    future = executor.submit(run_file, "instcombine", file_path, file_title)
                    futures[future] = file

        else : 
            raise Exception("Unknown benchmark.") 

        total = len(futures)
        for idx, future in enumerate(concurrent.futures.as_completed(futures)):
            file_or_name = futures[future]
            try:
                future.result()
            except Exception as exc:
                print(f'{file_or_name} generated an exception: {exc}')
            percentage = ((idx + 1) / total) * 100
            print(f'{file_or_name} completed, {percentage:.2f}%')




def main():
    parser = argparse.ArgumentParser(
        prog="compare",
        description="Compare the performance of bv_decide vs. bitwuzla",
    )

    parser.add_argument(
        'benchmark', nargs='+', choices=['all', 'hackersdelight', 'instcombine', 'smtlib', 'alive']
    )
    parser.add_argument(
        '-j', '--jobs', type=int, default=1
    )

    args = parser.parse_args()
    benchmarks_to_run = ['hackersdelight', 'instcombine', 'smtlib'] if 'all' in args.benchmark else args.benchmark

    for b in benchmarks_to_run :
        compare(b, args.jobs)

if __name__ == "__main__":
    main()