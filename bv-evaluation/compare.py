#!/usr/bin/env python3
import argparse
import os
import random
import subprocess
import concurrent.futures
import shutil
import multiprocessing
import psutil
import time
import threading
from functools import partial
from pathlib import Path
import sys

# Common Bit-vector widths for certain benchmarks
bv_widths = [4, 8, 16, 32, 64]

# Root of the git repository
ROOT_DIR = (
    subprocess.check_output(["git", "rev-parse", "--show-toplevel"])
    .decode("utf-8")
    .strip()
)

# Directories for benchmarks
RESULTS_DIR_ALIVE = f"{ROOT_DIR}/bv-evaluation/results/Alive/"
BENCHMARK_DIR_ALIVE = f"{ROOT_DIR}/SSA/Projects/InstCombine/"

RESULTS_DIR_HACKERSDELIGHT = f"{ROOT_DIR}/bv-evaluation/results/HackersDelight/"
BENCHMARK_DIR_HACKERSDELIGHT = f"{ROOT_DIR}/SSA/Projects/InstCombine/HackersDelight/"

RESULTS_DIR_INSTCOMBINE = f"{ROOT_DIR}/bv-evaluation/results/InstCombine/"
BENCHMARK_DIR_INSTCOMBINE = f"{ROOT_DIR}/SSA/Projects/InstCombine/tests/proofs/"

RESULTS_DIR_SMTLIB = f"{ROOT_DIR}/bv-evaluation/results/SMT-LIB/"
BENCHMARK_DIR_SMTLIB = f"{ROOT_DIR}/bv-evaluation/SMT-LIB/"
SOLVER_COMMANDS = {
    "bitwuzla": lambda path: [f"{ROOT_DIR}/bv-evaluation/solvers/bitwuzla.sh", path],
    "bv_decide": lambda path: [f"{ROOT_DIR}/bv-evaluation/solvers/bv_decide.sh", path],
    "bv_decide-nokernel": lambda path: [
        f"{ROOT_DIR}/bv-evaluation/solvers/bv_decide-nokernel.sh",
        path,
    ],
    "coqQFBV": lambda path: [f"{ROOT_DIR}/bv-evaluation/solvers/coqQFBV.sh", path],
}

TIMEOUT = 1800  # seconds


def kill_process_tree(pid):
    try:
        parent = psutil.Process(pid)
        for child in parent.children(recursive=True):
            child.kill()
        parent.kill()
    except psutil.NoSuchProcess:
        pass


def monitor_memory(pid, memout_mb, flag):
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


def run_with_limits(cmd, timeout, memout_mb):
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


def save_output(solver, benchmark_path, stdout, stderr, out_dir):
    try:
        relative = os.path.relpath(benchmark_path, BENCHMARK_DIR_SMTLIB)
        out_path = Path(os.path.join(out_dir, relative))
        out_path.mkdir(parents=True, exist_ok=True)
        with open(out_path / (solver + ".stdout"), "w") as f_out:
            f_out.write(stdout)
        with open(out_path / (solver + ".stderr"), "w") as f_err:
            f_err.write(stderr)
    except Exception as e:
        print(f"Failed to save output for {benchmark_path}: {e}", file=sys.stderr)


def run_single_benchmark(solver_name, timeout, memout_mb, out_dir, benchmark_path):
    if solver_name not in SOLVER_COMMANDS:
        return (benchmark_path, "INVALID_SOLVER")
    cmd = SOLVER_COMMANDS[solver_name](benchmark_path)
    code, out, err = run_with_limits(cmd, timeout, memout_mb)
    save_output(solver_name, benchmark_path, out, err, out_dir)
    return (benchmark_path, code)


def find_smtlib_benchmarks(directory):
    paths = []
    for root, _, files in os.walk(directory):
        for file in files:
            if file.endswith(".smt2"):
                paths.append(os.path.join(root, file))
    return sorted(paths)


def select_smtlib_samples(benchmark_paths, seed, num_samples):
    """
    Randomly selects a subset of SMT-LIB benchmarks based on the provided seed.
    """
    random.seed(seed)
    selected_benchmarks = random.sample(
        benchmark_paths, min(num_samples, len(benchmark_paths))
    )
    return selected_benchmarks


def run_smtlib_benchmarks(benchmark_paths, solver, jobs, timeout, memout, output_dir):
    if solver == "all":
        all_results = {}
        for solver in SOLVER_COMMANDS.keys():
            print(f"\nRunning solver: {solver}")
            with multiprocessing.Pool(jobs) as pool:
                run_func = partial(
                    run_single_benchmark, solver, timeout, memout, output_dir
                )
                results = pool.map(run_func, benchmark_paths)
            all_results[solver] = results
            print(f"\nSummary for solver: {solver}")
            for path, code in results:
                print(f"{path} -> {code}")
    else:
        with multiprocessing.Pool(jobs) as pool:
            run_func = partial(
                run_single_benchmark, solver, timeout, memout, output_dir
            )
            results = pool.map(run_func, benchmark_paths)

        print(f"\nSummary for solver: {solver}")
        for path, code in results:
            print(f"{path} -> {code}")


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
            print(f"Failed to delete {item_path}. Reason: {e}")


def run_file(file_to_run: str, log_file_path: str, timeout = TIMEOUT):
    """
    Runs a single Lean file and logs its output.
    file_to_run: The full path to the .lean file to execute.
    log_file_path: The file to write the logs in.
    """
    cmd_prefix = "lake lean "

    # Construct log file name including original file's base name and bit-width
    with open(log_file_path, "w") as log_file:
        cmd = cmd_prefix + file_to_run
        print(f"Running: {cmd}")
        try:
            subprocess.Popen(
                cmd, cwd=ROOT_DIR, stdout=log_file, stderr=log_file, shell=True
            ).wait(timeout=timeout)
        except subprocess.TimeoutExpired:
            log_file.truncate(0)
            log_file.write(f"timeout of {timeout} seconds reached\n")
            print(f"{file_to_run} - timeout of {timeout} seconds reached")


def run_hdel(temp_file_path, log_file_path, timeout=TIMEOUT):
    """
    A specialized 'run_file' for hacker's delight,
    that cleans up on the temporary files that are created
    after execution.
    """
    run_file(temp_file_path, log_file_path, timeout)
    # Clean up the temporary file created for this specific bit-width and original file for hackersdelight
    os.remove(temp_file_path)
    print(f"Deleted temporary file: {temp_file_path}")


def compare(
    benchmark: str,
    solver: str,
    jobs: int,
    reps: int,
    timeout: int,
    memout: int,
    num_samples,
    seed,
):
    """Processes benchmarks using a thread pool."""
    with concurrent.futures.ThreadPoolExecutor(max_workers=jobs) as executor:
        futures = {}

        if benchmark == "hackersdelight":
            # Iterate through all .lean files in the HackersDelight directory
            clear_folder(RESULTS_DIR_HACKERSDELIGHT)
            os.makedirs(RESULTS_DIR_HACKERSDELIGHT, exist_ok=True)
            hackers_delight_files = os.listdir(BENCHMARK_DIR_HACKERSDELIGHT)
            for original_file_name in hackers_delight_files:
                if not original_file_name.endswith(".lean"):
                    continue  # Skip non-Lean files

                original_file_path = os.path.join(
                    BENCHMARK_DIR_HACKERSDELIGHT, original_file_name
                )
                # Read the content of the original template file
                with open(original_file_path, "r", encoding="utf-8") as f:
                    original_content = f.read()

                # Get the base name of the original file (e.g., "my_template_file")
                original_file_base = os.path.splitext(original_file_name)[0]

                for width in bv_widths:
                    # Apply both replacements: 'sorry' to 'bv_compare'' and 'WIDTH' to actual width
                    modified_content = original_content.replace(
                        "sorry", "bv_compare'"
                    ).replace("WIDTH", str(width))

                    # Create a new temporary filename that includes original file's base name and width
                    temp_filename = f"{original_file_base}_{width}.lean"
                    temp_file_path = os.path.join(
                        BENCHMARK_DIR_HACKERSDELIGHT, temp_filename
                    )

                    # Write the modified content to the temporary file
                    with open(temp_file_path, "w", encoding="utf-8") as temp_file:
                        temp_file.write(modified_content)

                    for r in range(reps):
                        # Submit the temporary file to be run.
                        # log_file_base_name will be 'original_file_base'
                        # specific_arg_for_log_name will be the 'width'
                        log_file_name = (
                            f"{original_file_base}_{str(width)}_r{str(r)}.txt"
                        )
                        log_file_path = os.path.join(
                            RESULTS_DIR_HACKERSDELIGHT, log_file_name
                        )
                        future = executor.submit(
                            run_hdel, temp_file_path, log_file_path
                        )
                        futures[future] = (
                            temp_file_path  # Store the name of the temporary file for progress reporting
                        )

        elif benchmark == "instcombine":
            clear_folder(RESULTS_DIR_INSTCOMBINE)
            os.makedirs(RESULTS_DIR_INSTCOMBINE, exist_ok=True)

            for file in os.listdir(BENCHMARK_DIR_INSTCOMBINE):
                if "_proof" in file and file.endswith(
                    ".lean"
                ):  # Ensure it's a Lean file
                    for r in range(reps):
                        file_path = os.path.join(BENCHMARK_DIR_INSTCOMBINE, file)
                        file_title = os.path.splitext(file)[0]
                        log_file_path = os.path.join(
                            RESULTS_DIR_INSTCOMBINE, f"{file_title}_r{str(r)}.txt"
                        )
                        future = executor.submit(
                            run_file, "instcombine", file_path, log_file_path
                        )
                        futures[future] = file_path

        elif benchmark == "smtlib":
            clear_folder(RESULTS_DIR_SMTLIB)
            os.makedirs(RESULTS_DIR_SMTLIB, exist_ok=True)
            benchmark_paths = find_smtlib_benchmarks(BENCHMARK_DIR_SMTLIB)
            benchmark_paths = select_smtlib_samples(
                benchmark_paths, seed, num_samples
            )
            run_smtlib_benchmarks(
                benchmark_paths, solver, jobs, timeout, memout, RESULTS_DIR_SMTLIB
            )

        else:
            raise Exception("Unknown benchmark.")

        total = len(futures)
        for idx, future in enumerate(concurrent.futures.as_completed(futures)):
            file_path = futures[future]
            try:
              future.result()
            except Exception as exc:
                print(f"{file_path} generated an exception: {exc}")
                raise exc
            percentage = ((float(idx) + float(1)) / float(total)) * 100
            print(f"{file_path} completed, {percentage:.2f}%")


def main():
    parser = argparse.ArgumentParser(
        prog="compare",
        description="Compare performance across benchmarks and solvers",
    )

    parser.add_argument(
        "benchmark",
        nargs="+",
        choices=["all", "hackersdelight", "instcombine", "smtlib", "alive"],
        help="Which benchmarks to run",
    )
    parser.add_argument(
        "-s",
        "--seed",
        type=int,
        default=42,
        help="Seed for random selection of SMT-LIB benchmarks",
    )
    parser.add_argument(
        "-n",
        "--num_samples",
        type=int,
        default=10,
        help="Number of SMT-LIB benchmarks to randomly select",
    )
    parser.add_argument(
        "-j", "--jobs", type=int, default=1, help="Parallel jobs for all benchmarks"
    )
    parser.add_argument(
        "-r", "--repetitions", type=int, default=1, help="Repetitions for benchmarks"
    )
    parser.add_argument(
        "-t",
        "--timeout",
        type=int,
        default=TIMEOUT,
        help="Timeout (in seconds) per benchmark",
    )
    parser.add_argument(
        "-m",
        "--memout",
        type=int,
        default=1024,
        help="Memory limit (in MB) per SMT-LIB benchmark",
    )
    parser.add_argument(
        "--solver",
        choices=list(SOLVER_COMMANDS.keys()) + ["all"],
        default="all",
        help="Solver for SMT-LIB benchmarks",
    )

    args = parser.parse_args()
    benchmarks_to_run = (
        ["hackersdelight", "instcombine", "smtlib"]
        if "all" in args.benchmark
        else args.benchmark
    )

    for b in benchmarks_to_run:
        compare(
            b,
            args.solver,
            args.jobs,
            args.repetitions,
            args.timeout,
            args.memout,
            args.num_samples,
            args.seed,
        )


if __name__ == "__main__":
    main()
