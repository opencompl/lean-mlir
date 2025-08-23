#!/usr/bin/env python3

import sys
import os
import shutil
import subprocess
import re
import argparse
import concurrent.futures

ROOT_DIR = (
    subprocess.check_output(["git", "rev-parse", "--show-toplevel"])
    .decode("utf-8")
    .strip()
)
TIMEOUT = 1800  # seconds

LLVM_BUILD_DIR = "~/llvm-project/build/bin/"

LLC_ASM_DIR = (
    f"{ROOT_DIR}/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/LLC_ASM/"
)
XDSL_ASM_DIR = (
    f"{ROOT_DIR}/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/XDSL_ASM/"
)
MCA_LEANMLIR_DIR = (
    f"{ROOT_DIR}/SSA/Projects/LLVMRiscV/Evaluation/mca-results/Lean-MLIR/"
)
MCA_LLVM_DIR = (
    f"{ROOT_DIR}/SSA/Projects/LLVMRiscV/Evaluation/mca-results/LLVM/"
)
LOGS_DIR = f"{ROOT_DIR}/SSA/Projects/LLVMRiscV/Evaluation/mca-results/logs/"

def create_missing_folders(): 
    if not os.path.exists(MCA_LEANMLIR_DIR):
        os.makedirs(MCA_LEANMLIR_DIR)
    if not os.path.exists(MCA_LLVM_DIR):
        os.makedirs(MCA_LLVM_DIR)
    if not os.path.exists(LOGS_DIR):
        os.makedirs(LOGS_DIR)


def clear_folder(folder):
    """
    Delete all the files in `folder`
    """
    for filename in os.listdir(folder):
        file_path = os.path.join(folder, filename)
        try:
            if os.path.isfile(file_path) or os.path.islink(file_path):
                os.unlink(file_path)
            elif os.path.isdir(file_path):
                shutil.rmtree(file_path)
        except Exception as e:
            print("Failed to delete %s. Reason: %s" % (file_path, e))


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
    print(f"Removing unrealize casts from '{input_file}'.")
    cmd_base = (
        "llvm-mca -mtriple=riscv64 -mcpu=sifive-u74 -mattr=+m,+zba,+zbb,+zbs "
    )
    cmd = LLVM_BUILD_DIR + cmd_base + input_file + " > " + output_file
    run_command(cmd, log_file)
    

def clear_folders():
    clear_folder(LOGS_DIR)
    clear_folder(MCA_LEANMLIR_DIR)
    clear_folder(MCA_LLVM_DIR)


def clear_empty_logs():
    """
    Only leave in the logs folder the files that contain something meaningful.
    """
    for filename in os.listdir(LOGS_DIR):
        file_path = os.path.join(LOGS_DIR, filename)
        if os.path.getsize(file_path) == 0:
            try:
                if os.path.isfile(file_path) or os.path.islink(file_path):
                    os.unlink(file_path)
                elif os.path.isdir(file_path):
                    shutil.rmtree(file_path)
            except Exception:
                print("Failed to delete {filename}")
        elif "lake" in filename:
            lines = open(file_path).readlines()
            meaningful_lines = 0
            for line in lines:
                if "warning" in line:
                    continue
                elif "Replayed" in line:
                    continue
                else:
                    meaningful_lines += 1
            if meaningful_lines == 0:
                try:
                    if os.path.isfile(file_path) or os.path.islink(file_path):
                        os.unlink(file_path)
                    elif os.path.isdir(file_path):
                        shutil.rmtree(file_path)
                except Exception:
                    print("Failed to delete {filename}")


def run_tests():
    # extract mlir blocks and put them all in separate files
    create_missing_folders()
    clear_folders()

    for filename in os.listdir(XDSL_ASM_DIR):
        input_file = os.path.join(XDSL_ASM_DIR, filename)
        basename, _ = os.path.splitext(filename)
        output_file = os.path.join(MCA_LEANMLIR_DIR, basename + '.out')
        log_file = open(os.path.join(LOGS_DIR, 'xdsl_' + filename),'w')
        mca_analysis(input_file, output_file, log_file)

    for filename in os.listdir(LLC_ASM_DIR):
        input_file = os.path.join(LLC_ASM_DIR, filename)
        basename, _ = os.path.splitext(filename)
        output_file = os.path.join(MCA_LLVM_DIR, basename + '.out')
        log_file = open(os.path.join(LOGS_DIR, 'llvm_' + filename),'w')
        mca_analysis(input_file, output_file, log_file)

    clear_empty_logs()

def main():
    run_tests()


if __name__ == "__main__":
    main()
