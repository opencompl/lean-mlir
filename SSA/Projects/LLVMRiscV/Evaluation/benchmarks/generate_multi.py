#!/usr/bin/env python3

import subprocess
import os
import shutil
import argparse

MLIR_fuzz_DIR_PATH = (
    f"~/mlir-fuzz"
)

ROOT_DIR_PATH = (
    subprocess.check_output(["git", "rev-parse", "--show-toplevel"])
    .decode("utf-8")
    .strip()
)

MLIR_multi_DIR_PATH = (
    f"{ROOT_DIR_PATH}/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/MLIR_multi/"
)


def create_version_log():
    """
    Checks the git hash of `mlir-fuzz` and saves it to `MLIR_multi/version_log.txt`.
    """
    
    git_command = ["git", "rev-parse", "--short", "HEAD"]
    external_repo = os.path.expanduser(MLIR_fuzz_DIR_PATH)
    result = subprocess.run(
        git_command,
        cwd=external_repo,
        capture_output=True,
        text=True,
        check=True 
    )
    
    commit_hash = result.stdout.strip()
    
    log_file_path = os.path.join(MLIR_multi_DIR_PATH, "version_log.txt")
    log_file = open(log_file_path, "w")
    log_file.write(f"MLIR-fuzz commit hash: {commit_hash}\n")
    log_file.close()


def generate_benchmarks(num_programs, min_size, max_size):
    if not os.path.exists(MLIR_multi_DIR_PATH):
        os.makedirs(MLIR_multi_DIR_PATH)
    else:
        shutil.rmtree(MLIR_multi_DIR_PATH)
        os.makedirs(MLIR_multi_DIR_PATH)

    create_version_log()

    for size in range(min_size, max_size + 1):
        output_file = f"{MLIR_multi_DIR_PATH}/output_{size}.mlir"
        command = (f"{MLIR_fuzz_DIR_PATH}/build/bin/mlir-enumerate {MLIR_fuzz_DIR_PATH}/dialects/llvm.mlir " +
                f"--exact-size=1 --max-num-ops={size} --min-constant-value=-50 --max-constant-value=50  --min-num-args=1 --strategy=random --max-programs={num_programs} " +
                f"> {output_file}")
        
        print(f"Generating benchmarks of size {size} into {output_file}")
        print(command)
        os.system(command)
    
def main():
    parser = argparse.ArgumentParser(
        prog="generate",
        description="Generate a new set of benchmarks in all the representations, from MLIR to RISCV assembly.",
    )

    parser.add_argument(
        "--min_size",
        type=int,
        help="Min #ops of the synthesized programs. ",
    )
    
    parser.add_argument(
        "--max_size",
        type=int,
        help="Max #ops of the synthesized programs. ",
    )
    
    parser.add_argument(
        "--num",
        type=int,
        help="#programs for each size in the [min_size, max_size] interval. ",
    )


    args = parser.parse_args()
    generate_benchmarks(args.num, args.min_size, args.max_size)


if __name__ == "__main__":
    main()
