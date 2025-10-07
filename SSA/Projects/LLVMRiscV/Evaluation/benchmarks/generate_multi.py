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


# ./build/bin/mlir-enumerate dialects/llvm.mlir --exact-size=1 --max-num-ops=3 --min-constant-value=-50 --max-constant-value=50 --max-programs=10 > generated/output.mlir

def generate_benchmarks(num_programs, min_size, max_size):
    if not os.path.exists(MLIR_multi_DIR_PATH):
        os.makedirs(MLIR_multi_DIR_PATH)
    else:
        shutil.rmtree(MLIR_multi_DIR_PATH)
        os.makedirs(MLIR_multi_DIR_PATH)

    for size in range(min_size, max_size + 1):
        output_file = f"{MLIR_multi_DIR_PATH}/output_{size}.mlir"
        command = (f"{MLIR_fuzz_DIR_PATH}/build/bin/mlir-enumerate {MLIR_fuzz_DIR_PATH}/dialects/llvm.mlir " +
                f"--exact-size=1 --max-num-ops={size} --min-constant-value=-50 --max-constant-value=50 --strategy=random --max-programs={num_programs} " +
                f"> {output_file}")
        
        print(f"Generating benchmarks of size {size} into {output_file}")
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
