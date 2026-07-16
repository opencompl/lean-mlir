#!/usr/bin/env python3

import os
import shutil
import subprocess
import argparse
from evallib import taskqueue

ROOT_DIR = (
    subprocess.check_output(["git", "rev-parse", "--show-toplevel"])
    .decode("utf-8")
    .strip()
)
TIMEOUT = 1800  # seconds

LLC_ASM_globalisel_DIR = (
    f"{ROOT_DIR}/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/LLC_ASM_globalisel/"
)
LLC_ASM_selectiondag_DIR = (
    f"{ROOT_DIR}/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/LLC_ASM_selectiondag/"
)
LLC_ASM_DIR = f"{ROOT_DIR}/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/LLC_ASM/"
XDSL_ASM_DIR = f"{ROOT_DIR}/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/XDSL_ASM/"
XDSL_opt_ASM_DIR = (
    f"{ROOT_DIR}/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/XDSL_opt_ASM/"
)
MCA_LEANMLIR_DIR = (
    f"{ROOT_DIR}/SSA/Projects/LLVMRiscV/Evaluation/mca-analysis/results/LEANMLIR/"
)
MCA_LEANMLIR_opt_DIR = (
    f"{ROOT_DIR}/SSA/Projects/LLVMRiscV/Evaluation/mca-analysis/results/LEANMLIR_opt/"
)
MCA_LLVM_globalisel_DIR = f"{ROOT_DIR}/SSA/Projects/LLVMRiscV/Evaluation/mca-analysis/results/LLVM_globalisel/"
MCA_LLVM_selectiondag_DIR = f"{ROOT_DIR}/SSA/Projects/LLVMRiscV/Evaluation/mca-analysis/results/LLVM_selectiondag/"
LOGS_DIR = f"{ROOT_DIR}/SSA/Projects/LLVMRiscV/Evaluation/mca-analysis/results/logs/"


AUTOGEN_DIR_PATHS = [
    MCA_LEANMLIR_DIR,
    MCA_LEANMLIR_opt_DIR,
    MCA_LLVM_globalisel_DIR,
    MCA_LLVM_selectiondag_DIR,
    LOGS_DIR,
]


def setup_benchmarking_directories():
    """
    Create clean directories to store the benchmarks.
    """
    results_dir = f"{ROOT_DIR}/SSA/Projects/LLVMRiscV/Evaluation/mca-analysis/results/"
    if not os.path.exists(results_dir):
        os.makedirs(results_dir)
    for directory in AUTOGEN_DIR_PATHS:
        if not os.path.exists(directory):
            os.makedirs(directory)
        else:
            shutil.rmtree(directory)
            os.makedirs(directory)


def run_command(cmd, log_file, timeout=TIMEOUT):
    try:
        print(cmd)
        subprocess.Popen(
            cmd, cwd=ROOT_DIR, stdout=log_file, stderr=log_file, shell=True
        ).wait(timeout=timeout)
    except subprocess.TimeoutExpired:
        log_file.truncate(0)
        log_file.write(f"timeout of {timeout} seconds reached\n")
        print(f"{log_file} - timeout of {timeout} seconds reached")


def mca_analysis(input_file, output_file, log_file):
    """
    Run MCA performance analysis on the RISCV asm `input_file`.
    """
    cmd_base = "llvm-mca -mtriple=riscv64 -mcpu=sifive-u74 -mattr=+m,+zba,+zbb,+zbs "
    cmd = cmd_base + input_file + " > " + output_file
    run_command(cmd, log_file)


def run_tests():
    # clear results directory
    setup_benchmarking_directories()

    # Parse CLI arguments
    parser = argparse.ArgumentParser()
    taskqueue.add_cli_arguments(parser)

    # idx = 0
    # for filename in os.listdir(XDSL_ASM_DIR):
    #     input_file = os.path.join(XDSL_ASM_DIR, filename)
    #     basename, _ = os.path.splitext(filename)
    #     output_file = os.path.join(MCA_LEANMLIR_DIR, basename + '.out')
    #     log_file = open(os.path.join(LOGS_DIR, 'xdsl_' + filename),'w')
    #     mca_analysis(input_file, output_file, log_file)
    #     idx += 1
    #     percentage = ((float(idx) + float(1)) / float(len(os.listdir(XDSL_ASM_DIR)))) * 100
    #     print(f"running mca analysis on lean-mlir asm: {percentage:.2f}%")

    idx = 0
    for filename in os.listdir(XDSL_opt_ASM_DIR):
        input_file = os.path.join(XDSL_opt_ASM_DIR, filename)
        basename, _ = os.path.splitext(filename)
        output_file = os.path.join(MCA_LEANMLIR_opt_DIR, basename + ".out")
        log_file = open(os.path.join(LOGS_DIR, "xdsl_opt_" + filename), "w")
        mca_analysis(input_file, output_file, log_file)
        idx += 1
        percentage = (
            (float(idx) + float(1)) / float(len(os.listdir(XDSL_opt_ASM_DIR)))
        ) * 100
        print(f"running mca analysis on lean-mlir asm (opt): {percentage:.2f}%")

    idx = 0
    for filename in os.listdir(LLC_ASM_globalisel_DIR):
        input_file = os.path.join(LLC_ASM_globalisel_DIR, filename)
        basename, _ = os.path.splitext(filename)
        output_file = os.path.join(MCA_LLVM_globalisel_DIR, basename + ".out")
        log_file = open(os.path.join(LOGS_DIR, "llvm_globalisel_" + filename), "w")
        mca_analysis(input_file, output_file, log_file)
        idx += 1
        percentage = (
            (float(idx) + float(1)) / float(len(os.listdir(LLC_ASM_globalisel_DIR)))
        ) * 100
        print(f"running mca analysis on llc asm (globalISel): {percentage:.2f}%")

    idx = 0
    for filename in os.listdir(LLC_ASM_selectiondag_DIR):
        input_file = os.path.join(LLC_ASM_selectiondag_DIR, filename)
        basename, _ = os.path.splitext(filename)
        output_file = os.path.join(MCA_LLVM_selectiondag_DIR, basename + ".out")
        log_file = open(os.path.join(LOGS_DIR, "llvm_selectiondag_" + filename), "w")
        mca_analysis(input_file, output_file, log_file)
        idx += 1
        percentage = (
            (float(idx) + float(1)) / float(len(os.listdir(LLC_ASM_selectiondag_DIR)))
        ) * 100
        print(f"running mca analysis on llc asm (selectionDAG): {percentage:.2f}%")


def main():
    run_tests()


if __name__ == "__main__":
    main()
