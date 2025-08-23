#!/usr/bin/env python3

import sys
import os
import shutil
import subprocess
import re
import argparse
import concurrent.futures
from xdsl.rewriter import Rewriter
from xdsl.xdsl_opt_main import xDSLOptMain
from xdsl.rewriter import InsertPoint
from xdsl.ir import Block
from xdsl.dialects.builtin import ModuleOp, NoneAttr, StringAttr, FunctionType
from xdsl.dialects import llvm
from xdsl.dialects.riscv import IntRegisterType
from xdsl.dialects import riscv_func
from xdsl.transforms.reconcile_unrealized_casts import ReconcileUnrealizedCastsPass


ROOT_DIR = (
    subprocess.check_output(["git", "rev-parse", "--show-toplevel"])
    .decode("utf-8")
    .strip()
)
TIMEOUT = 1800  # seconds

LLVM_BUILD_DIR = "~/llvm-project/build/bin/"

LLVM_DIR = f"{ROOT_DIR}/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/LLVM/"
LLVMIR_DIR = (
    f"{ROOT_DIR}/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/LLVMIR/"
)
MLIR_bb0_DIR = (
    f"{ROOT_DIR}/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/MLIR_bb0/"
)
MLIR_single_DIR = (
    f"{ROOT_DIR}/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/MLIR_single/"
)
MLIR_multi_DIR = (
    f"{ROOT_DIR}/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/MLIR_multi/"
)
LLC_ASM_DIR = (
    f"{ROOT_DIR}/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/LLC_ASM/"
)
LEANMLIR_ASM_DIR = (
    f"{ROOT_DIR}/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/LEANMLIR_ASM/"
)
XDSL_no_casts_DIR = (
    f"{ROOT_DIR}/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/XDSL_no_casts/"
)
XDSL_reg_alloc_DIR = (
    f"{ROOT_DIR}/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/XDSL_reg_alloc/"
)
XDSL_ASM_DIR = (
    f"{ROOT_DIR}/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/XDSL_ASM/"
)
LOGS_DIR = f"{ROOT_DIR}/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/logs/"

def create_missing_folders(): 
    if not os.path.exists(LLVM_DIR):
        os.makedirs(LLVM_DIR)
    if not os.path.exists(LLVMIR_DIR):
        os.makedirs(LLVMIR_DIR)
    if not os.path.exists(MLIR_bb0_DIR):
        os.makedirs(MLIR_bb0_DIR)
    if not os.path.exists(MLIR_single_DIR):
        os.makedirs(MLIR_single_DIR)
    if not os.path.exists(LLC_ASM_DIR):
        os.makedirs(LLC_ASM_DIR)
    if not os.path.exists(LEANMLIR_ASM_DIR):
        os.makedirs(LEANMLIR_ASM_DIR)
    if not os.path.exists(XDSL_no_casts_DIR):
        os.makedirs(XDSL_no_casts_DIR)
    if not os.path.exists(XDSL_reg_alloc_DIR):
        os.makedirs(XDSL_reg_alloc_DIR)
    if not os.path.exists(XDSL_ASM_DIR):
        os.makedirs(XDSL_ASM_DIR)
    if not os.path.exists(LOGS_DIR):
        os.makedirs(LOGS_DIR)

def delete_if_malformed(file_path): 
    """
    Check if the content of a file is empty, delete if it is.
    """
    if os.path.getsize(file_path) == 0: 
        if os.path.isfile(file_path) or os.path.islink(file_path):
                os.unlink(file_path)
        elif os.path.isdir(file_path):
                shutil.rmtree(file_path)
    file = open(file_path,'r')
    lines = file.readlines()
    for line in lines: 
        # brittle: what if a variable is called "Error"?
        if 'Error' in line: 
            if os.path.isfile(file_path) or os.path.islink(file_path):
                os.unlink(file_path)
            elif os.path.isdir(file_path):
                shutil.rmtree(file_path)
            return

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


def extract_mlir_blocks(input_file, output_base, max_functions):
    """
    Extracts individual MLIR module blocks (functions) from a large input file
    and saves each into a separate file.
    """
    try:
        with open(input_file, "r") as f:
            content = f.read()
    except FileNotFoundError:
        print(f"Error: Input file '{input_file}' not found. ")
        return
    except Exception as e:
        print(f"Error reading input file: {e}")
        return

    delimiter_pattern = r"\n// -{5,}.*?\n"
    blocks = re.split(delimiter_pattern, content, flags=re.DOTALL)

    function_count = 0
    for i, block_content in enumerate(blocks):
        if function_count >= max_functions:
            print(f"Reached maximum of {max_functions} functions. Stopping extraction.")
            break

        clean_block = block_content.strip()

        if clean_block and "module {" in clean_block:
            original_mlir_filename = os.path.join(
                output_base, f"function_{function_count}.mlir"
            )
            try:
                with open(original_mlir_filename, "w") as out_f:
                    out_f.write(clean_block)
                    out_f.write("\n")
                print(
                    f"Extracted function {function_count} to '{original_mlir_filename}'"
                )
                function_count += 1
            except Exception as e:
                print(f"Error writing to file or during transformation: {e}")
                # Continue trying to extract other functions even if one fails
                continue


def MLIR_opt_arith_llvm(input_file, output_file, log_file):
    """
    Run mlir-opt and convert a file into LLVM dialect.
    """
    print(f"Converting '{input_file}' to LLVM dialect in {output_file} ")
    cmd_base = (
        "mlir-opt -convert-arith-to-llvm -convert-func-to-llvm --mlir-print-op-generic "
    )
    cmd = LLVM_BUILD_DIR + cmd_base + input_file + " -o " + output_file
    run_command(cmd, log_file)


def MLIR_translate_llvmir(input_file, output_file, log_file):
    """
    Run mlir-translate and translate a file from LLVM dialect to LLVMIR.
    """
    print(f"Compiling '{input_file}' to LLVM IR. ")
    cmd_base = "mlir-translate --mlir-to-llvmir "
    cmd = LLVM_BUILD_DIR + cmd_base + input_file + " -o " + output_file
    run_command(cmd, log_file)


def LLC_compile_riscv(input_file, output_file, log_file):
    """
    Compile LLVMIR to RISCV assembly with llc.
    """
    print(f"Compiling '{input_file}' to RISC-V assembly using llc.")
    cmd_base = (
        LLVM_BUILD_DIR
        + "llc -march=riscv64 -mcpu=generic-rv64 -mattr=+m,+b -filetype=asm "
    )
    cmd = cmd_base + input_file + " -o " + output_file
    run_command(cmd, log_file)



def extract_bb0(input_file, output_file):
    """
    Extract the first basic block from the MLIR file.
    """
    o_f = open(output_file, "w")
    in_block = False
    try:
        with open(input_file, "r") as f:
            for line in f:
                line = line.strip()
                if line.startswith("^bb0("):
                    in_block = True
                    o_f.write("{\n")
                    o_f.write(line + "\n")
                    continue
                if in_block:
                    o_f.write(line + "\n")
                    if '"llvm.return"' in line:
                        o_f.write("}" + "\n")
                        o_f.close()
                        return

    except FileNotFoundError:
        print(f"Error: The file '{input_file}' was not found.", file=sys.stderr)
        sys.exit(1)


def LAKE_compile_riscv64(jobs):
    """
    Lower the input file to RISCV with Lean-MLIR, using multiple threads.
    """
    with concurrent.futures.ThreadPoolExecutor(max_workers=jobs) as executor:
        futures = {}

        for filename in os.listdir(MLIR_bb0_DIR):
            input_file = os.path.join(MLIR_bb0_DIR, filename)
            basename, _ = os.path.splitext(filename)
            output_file = os.path.join(LEANMLIR_ASM_DIR, basename + '.mlir')
            log_file = open(LOGS_DIR + "lake_" + basename + ".mlir", "w")
            # todo: cmd_base is very sneaky and should be corrected, I could not find a way
            print(f"Compiling '{input_file}' to RISC-V assembly in Lean-MLIR..")
            cmd_base = "cd; cd lean-mlir; lake exe opt --passriscv64 "
            cmd = cmd_base + input_file + " > " + output_file
            future = executor.submit(run_command, cmd, log_file)
            futures[future] = input_file


        total = len(futures)
        for idx, future in enumerate(concurrent.futures.as_completed(futures)):
            file_path = futures[future]
            future.result()
            percentage = ((float(idx) + float(1)) / float(total)) * 100
            print(f"{file_path} completed, {percentage:.2f}%")
    

# this is just a temporary solution because I don't understand python classes.
def XDSL_remove_casts(input_file, output_file, log_file):
    """
    Remove unrealized casts from the RISCV64 dialect MLIR files with xdsl.
    """
    print(f"Removing unrealize casts from '{input_file}'.")
    cmd_base = (
        f"python3 {ROOT_DIR}/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/remove_casts.py "
    )
    cmd = cmd_base + input_file + " > " + output_file
    run_command(cmd, log_file)

def XDSL_reg_alloc(input_file, output_file, log_file):
    """
    Remove unrealized casts from the RISCV64 dialect MLIR files with xdsl.
    """
    print(f"Removing unrealize casts from '{input_file}'.")
    cmd_base = (
        "xdsl-opt -p riscv-allocate-registers "
    )
    cmd = cmd_base + input_file + " > " + output_file
    run_command(cmd, log_file)

def XDSL_compile_riscv(input_file, output_file, log_file):
    """
    Remove unrealized casts from the RISCV64 dialect MLIR files with xdsl.
    """
    print(f"Removing unrealize casts from '{input_file}'.")
    cmd_base = (
        "xdsl-opt -t riscv-asm "
    )
    cmd = cmd_base + input_file + " > " + output_file
    run_command(cmd, log_file)

def clear_folders():
    clear_folder(LLVM_DIR)
    clear_folder(LLVMIR_DIR)
    clear_folder(MLIR_bb0_DIR)
    clear_folder(MLIR_single_DIR)
    clear_folder(LLC_ASM_DIR)
    clear_folder(LEANMLIR_ASM_DIR)
    clear_folder(LOGS_DIR)
    clear_folder(XDSL_no_casts_DIR)
    clear_folder(XDSL_reg_alloc_DIR)
    clear_folder(XDSL_ASM_DIR)


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


def generate_benchmarks(file_name, num, jobs):
    create_missing_folders()
    clear_folders()
    input_file = MLIR_multi_DIR + file_name

    # extract mlir blocks and put them all in separate files
    extract_mlir_blocks(input_file, MLIR_single_DIR, num)

    # Run mlir-opt and convert into LLVM dialect
    for filename in os.listdir(MLIR_single_DIR):
        input_file = os.path.join(MLIR_single_DIR, filename)
        basename, _ = os.path.splitext(filename)
        output_file = os.path.join(LLVM_DIR, basename + '.ll')
        log_file = open(os.path.join(LOGS_DIR, basename + '_mlir_opt.log'), 'w')
        MLIR_opt_arith_llvm(input_file, output_file, log_file)
        if os.path.exists(output_file):
            delete_if_malformed(output_file)

    # Run mlir-translate and convert LLVM into LLVMIR
    for filename in os.listdir(LLVM_DIR):
        input_file = os.path.join(LLVM_DIR, filename)
        basename, _ = os.path.splitext(filename)
        output_file = os.path.join(LLVMIR_DIR, basename + '.mlir')
        log_file = open(os.path.join(LOGS_DIR, basename + '_mlir_translate.log'), 'w')
        MLIR_translate_llvmir(input_file, output_file, log_file)
        if os.path.exists(output_file):
            delete_if_malformed(output_file)

    # Use llc to compile LLVMIR into RISCV
    for filename in os.listdir(LLVMIR_DIR):
        input_file = os.path.join(LLVMIR_DIR, filename)
        basename, _ = os.path.splitext(filename)
        output_file = os.path.join(LLC_ASM_DIR, basename + '.s')
        log_file = open(os.path.join(LOGS_DIR, basename + '_llc.log'), 'w')
        LLC_compile_riscv(input_file, output_file, log_file)
        if os.path.exists(output_file):
            delete_if_malformed(output_file)

    # Extract bb0
    for filename in os.listdir(LLVM_DIR):
        input_file = os.path.join(LLVM_DIR, filename)
        basename, _ = os.path.splitext(filename)
        output_file = os.path.join(MLIR_bb0_DIR, basename + '.mlir')
        extract_bb0(input_file, output_file)
        if os.path.exists(output_file):
            delete_if_malformed(output_file)

    # Run the lean pass in parallel
    LAKE_compile_riscv64(jobs)
    for filename in os.listdir(LEANMLIR_ASM_DIR):
        delete_if_malformed(os.path.join(LEANMLIR_ASM_DIR, filename))

    # Remove unrealized casts 
    for filename in os.listdir(LEANMLIR_ASM_DIR):
        input_file = os.path.join(LEANMLIR_ASM_DIR, filename)
        basename, _ = os.path.splitext(filename)
        output_file = os.path.join(XDSL_no_casts_DIR, basename + '.mlir')
        log_file = open(os.path.join(LOGS_DIR, basename + '_xdsl_remove_casts.log'), 'w')
        XDSL_remove_casts(input_file, output_file, log_file)
        #this is not good but I got a weird error and wnated to finish the pipeline
        try: 
            delete_if_malformed(output_file)
        finally: 
            continue

    # Perform register allocation with XDSL 
    for filename in os.listdir(XDSL_no_casts_DIR):
        input_file = os.path.join(XDSL_no_casts_DIR, filename)
        basename, _ = os.path.splitext(filename)
        output_file = os.path.join(XDSL_reg_alloc_DIR, basename + '.mlir')
        log_file = open(os.path.join(LOGS_DIR, basename + '_xdsl_reg_alloc.log'), 'w')
        XDSL_reg_alloc(input_file, output_file, log_file)
        if os.path.exists(output_file):
            delete_if_malformed(output_file)

    # Compile to RISCV asm with XDSL 
    for filename in os.listdir(XDSL_reg_alloc_DIR):
        input_file = os.path.join(XDSL_reg_alloc_DIR, filename)
        basename, _ = os.path.splitext(filename)
        output_file = os.path.join(XDSL_ASM_DIR, basename + '.s')
        log_file = open(os.path.join(LOGS_DIR, basename + '_xdsl_riscv.log'), 'w')
        XDSL_reg_alloc(input_file, output_file, log_file)
        if os.path.exists(output_file):
            delete_if_malformed(output_file)

    clear_empty_logs()

def main():
    parser = argparse.ArgumentParser(
        prog="generate",
        description="Generate a new set of benchmarks in all the representations, from MLIR to RISCV assembly.",
    )

    parser.add_argument(
        "-i",
        "--input",
        type=str,
        default="out_1000.mlir",
        help="Name of the file containing the functions to lower. ",
    )

    parser.add_argument(
        "-n", "--num", type=int, default=100, help="Number of benchmarks to generate. "
    )

    parser.add_argument(
        "-j", "--jobs", type=int, default=1, help="Parallel jobs for all benchmarks"
    )

    args = parser.parse_args()
    generate_benchmarks(args.input, args.num, args.jobs)


if __name__ == "__main__":
    main()
