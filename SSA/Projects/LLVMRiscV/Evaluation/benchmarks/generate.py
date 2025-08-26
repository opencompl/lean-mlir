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


ROOT_DIR_PATH = (
    subprocess.check_output(["git", "rev-parse", "--show-toplevel"])
    .decode("utf-8")
    .strip()
)

TIMEOUT_SEC = 1800

LLVM_BUILD_DIR_PATH = "/opt/homebrew/opt/llvm/bin/"

#here
LLC_GLOBALISEL_ASM_DIR_PATH = (
    f"{ROOT_DIR_PATH}/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/LLC_GlobalISel_ASM/"
)

LLVM_DIR_PATH = f"{ROOT_DIR_PATH}/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/LLVM/"
LLVMIR_DIR_PATH = (
    f"{ROOT_DIR_PATH}/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/LLVMIR/"
)
MLIR_bb0_DIR_PATH = (
    f"{ROOT_DIR_PATH}/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/MLIR_bb0/"
)
MLIR_single_DIR_PATH = (
    f"{ROOT_DIR_PATH}/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/MLIR_single/"
)
MLIR_multi_DIR_PATH = (
    f"{ROOT_DIR_PATH}/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/MLIR_multi/"
)
LLC_ASM_DIR_PATH = (
    f"{ROOT_DIR_PATH}/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/LLC_ASM/"
)
LEANMLIR_ASM_DIR_PATH = (
    f"{ROOT_DIR_PATH}/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/LEANMLIR_ASM/"
)
XDSL_no_casts_DIR_PATH = (
    f"{ROOT_DIR_PATH}/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/XDSL_no_casts/"
)
XDSL_reg_alloc_DIR_PATH = (
    f"{ROOT_DIR_PATH}/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/XDSL_reg_alloc/"
)
XDSL_ASM_DIR_PATH = (
    f"{ROOT_DIR_PATH}/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/XDSL_ASM/"
)
LOGS_DIR_PATH = f"{ROOT_DIR_PATH}/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/logs/"

LLC_GLOBALISEL_ASM_DIR_PATH = (
    f"{ROOT_DIR_PATH}/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/LLC_GLOBALISEL_ASM/"
)

AUTOGEN_DIR_PATHS = [LLVM_DIR_PATH, LLVMIR_DIR_PATH, MLIR_bb0_DIR_PATH, MLIR_single_DIR_PATH, 
            LLC_ASM_DIR_PATH, LEANMLIR_ASM_DIR_PATH, XDSL_no_casts_DIR_PATH,XDSL_reg_alloc_DIR_PATH, XDSL_ASM_DIR_PATH,
              LOGS_DIR_PATH, LLC_GLOBALISEL_ASM_DIR_PATH ]

def setup_benchmarking_directories(): 
    """
    Create clean directories to store the benchmarks.
    """
    for directory in AUTOGEN_DIR_PATHS:
        if not os.path.exists(directory):
            os.makedirs(directory)
        else:       
            shutil.rmtree(directory)
            os.makedirs(directory)


def run_command(cmd, log_file, timeout=TIMEOUT_SEC):
    try:
        print(cmd)
        ret_code = subprocess.Popen(
            cmd, cwd=ROOT_DIR_PATH, stdout=log_file, stderr=log_file, shell=True
        ).wait(timeout=timeout)
        return ret_code
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


def MLIR_opt_arith_llvm(input_file, output_file, log_file, pass_dict):
    """
    Run mlir-opt and convert a file into LLVM dialect.
    """
    print(f"Converting '{input_file}' to LLVM dialect in {output_file} ")
    cmd_base = (
        "mlir-opt -convert-arith-to-llvm -convert-func-to-llvm --mlir-print-op-generic "
    )
    cmd = LLVM_BUILD_DIR_PATH + cmd_base + input_file + " -o " + output_file
    ret_code = run_command(cmd, log_file)
    pass_dict[output_file] = ret_code

def MLIR_translate_llvmir(input_file, output_file, log_file, pass_dict):
    """
    Run mlir-translate and translate a file from LLVM dialect to LLVMIR.
    """
    print(f"Compiling '{input_file}' to LLVM IR. ")
    cmd_base = "mlir-translate --mlir-to-llvmir "
    cmd = LLVM_BUILD_DIR_PATH + cmd_base + input_file + " -o " + output_file
    ret_code = run_command(cmd, log_file)
    pass_dict[output_file] = ret_code

def LLC_compile_riscv(input_file, output_file, log_file, pass_dict):
    """
    Compile LLVMIR to RISCV assembly with llc.
    """
    print(f"Compiling '{input_file}' to RISC-V assembly using llc.")
    cmd_base = (
        LLVM_BUILD_DIR_PATH
        + "llc -march=riscv64 -mcpu=generic-rv64 -mattr=+m,+b -filetype=asm "
    )
    cmd = cmd_base + input_file + " -o " + output_file
    ret_code = run_command(cmd, log_file)
    pass_dict[output_file] = ret_code

def LLC_compile_GLOBALISEL_riscv(input_file, output_file, log_file, pass_dict):
    """
    Compile LLVMIR to RISCV assembly with llc using the GlobalISel framework.
    """
    print(f"Compiling '{input_file}' to RISC-V assembly using llc (GlobalISel).")
    cmd_base = (
        LLVM_BUILD_DIR_PATH
        + "llc -march=riscv64 -mcpu=generic-rv64 --global-isel -mattr=+m,+b -filetype=asm "
    )
    cmd = cmd_base + input_file + " -o " + output_file
    ret_code = run_command(cmd, log_file)
    pass_dict[output_file] = ret_code


def extract_bb0(input_file, output_file, log_file):
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
        print(f"Error: The file '{input_file}' was not found.", file=log_file)
        sys.exit(1)


def LAKE_compile_riscv64(jobs, pass_dict):
    """
    Lower the input file to RISCV with Lean-MLIR, using multiple threads.
    """
    with concurrent.futures.ThreadPoolExecutor(max_workers=jobs) as executor:
        futures = {}

        for filename in os.listdir(MLIR_bb0_DIR_PATH):
            input_file = os.path.join(MLIR_bb0_DIR_PATH, filename)
            basename, _ = os.path.splitext(filename)
            output_file = os.path.join(LEANMLIR_ASM_DIR_PATH, basename + '.mlir')
            log_file = open(LOGS_DIR_PATH + basename + "_lake.mlir", "w")
            print(f"Compiling '{input_file}' to RISC-V assembly in Lean-MLIR..")
            cmd_base = f"cd {ROOT_DIR_PATH}; lake exe opt --passriscv64 "
            cmd = cmd_base + input_file + " > " + output_file
            future = executor.submit(run_command, cmd, log_file)
            futures[future] = output_file

        total = len(futures)
        for idx, future in enumerate(concurrent.futures.as_completed(futures)):
            file_path = futures[future]
            ret_code = future.result()
            pass_dict[file_path] = ret_code
            percentage = ((float(idx) + float(1)) / float(total)) * 100
            print(f"{file_path} completed, {percentage:.2f}%")
    

# this is just a temporary solution because I don't understand python classes.
def XDSL_remove_casts(input_file, output_file, log_file, pass_dict):
    """
    Remove unrealized casts from the RISCV64 dialect MLIR files with xdsl.
    """
    print(f"Removing unrealize casts from '{input_file}'.")
    cmd_base = (
        f"python3 {ROOT_DIR_PATH}/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/remove_casts.py "
    )
    cmd = cmd_base + input_file + " > " + output_file
    ret_code = run_command(cmd, log_file)
    pass_dict[output_file] = ret_code

def XDSL_reg_alloc(input_file, output_file, log_file, pass_dict):
    """
    Remove unrealized casts from the RISCV64 dialect MLIR files with xdsl.
    """
    print(f"Removing unrealize casts from '{input_file}'.")
    cmd_base = (
        "xdsl-opt -p riscv-allocate-registers "
    )
    cmd = cmd_base + input_file + " > " + output_file
    ret_code = run_command(cmd, log_file)
    pass_dict[output_file] = ret_code

def XDSL_compile_riscv(input_file, output_file, log_file, pass_dict):
    """
    Remove unrealized casts from the RISCV64 dialect MLIR files with xdsl.
    """
    print(f"Removing unrealize casts from '{input_file}'.")
    cmd_base = (
        "xdsl-opt -t riscv-asm "
    )
    cmd = cmd_base + input_file + " > " + output_file
    ret_code = run_command(cmd, log_file)
    pass_dict[output_file] = ret_code

def generate_benchmarks(file_name, num, jobs):
    setup_benchmarking_directories()
    input_file = MLIR_multi_DIR_PATH + file_name

    # extract mlir blocks and put them all in separate files
    extract_mlir_blocks(input_file, MLIR_single_DIR_PATH, num)

    MLIR_opt_file2ret = dict()
    # Run mlir-opt and convert into LLVM dialect
    for filename in os.listdir(MLIR_single_DIR_PATH):
        input_file = os.path.join(MLIR_single_DIR_PATH, filename)
        basename, _ = os.path.splitext(filename)
        output_file = os.path.join(LLVM_DIR_PATH, basename + '.ll')
        log_file = open(os.path.join(LOGS_DIR_PATH, basename + '_mlir_opt.log'), 'w')
        MLIR_opt_arith_llvm(input_file, output_file, log_file, MLIR_opt_file2ret)

    MLIR_translate_file2ret = dict()
    # Run mlir-translate and convert LLVM into LLVMIR
    for filename in os.listdir(LLVM_DIR_PATH):
        input_file = os.path.join(LLVM_DIR_PATH, filename)
        # only run the lowering if the previous pass was successful: 
        if MLIR_opt_file2ret[input_file] == 0: 
            basename, _ = os.path.splitext(filename)
            output_file = os.path.join(LLVMIR_DIR_PATH, basename + '.mlir')
            log_file = open(os.path.join(LOGS_DIR_PATH, basename + '_mlir_translate.log'), 'w')
            MLIR_translate_llvmir(input_file, output_file, log_file, MLIR_translate_file2ret)

    LLC_file2ret = dict()
    # Use llc to compile LLVMIR into RISCV
    for filename in os.listdir(LLVMIR_DIR_PATH):
        input_file = os.path.join(LLVMIR_DIR_PATH, filename)
        # only run the lowering if the previous pass was successful: 
        if MLIR_translate_file2ret[input_file] == 0: 
            basename, _ = os.path.splitext(filename)
            output_file = os.path.join(LLC_ASM_DIR_PATH, basename + '.s')
            log_file = open(os.path.join(LOGS_DIR_PATH, basename + '_llc.log'), 'w')
            LLC_compile_riscv(input_file, output_file, log_file, LLC_file2ret)
    
    LLC_GLOBALISEL_file2ret = dict()
    # Use llc to compile LLVMIR into RISCV
    for filename in os.listdir(LLVMIR_DIR_PATH):
        input_file = os.path.join(LLVMIR_DIR_PATH, filename)
        # only run the lowering if the previous pass was successful: 
        if MLIR_translate_file2ret[input_file] == 0: #previous pass succeded
            basename, _ = os.path.splitext(filename)
            output_file = os.path.join(LLC_GLOBALISEL_ASM_DIR_PATH, basename + '.s')
            log_file = open(os.path.join(LOGS_DIR_PATH, basename + '_GLOBALISEL_llc.log'), 'w')
            LLC_compile_GLOBALISEL_riscv(input_file, output_file, log_file, LLC_file2ret)

    # Extract bb0
    for filename in os.listdir(LLVM_DIR_PATH):
        input_file = os.path.join(LLVM_DIR_PATH, filename)
        basename, _ = os.path.splitext(filename)
        output_file = os.path.join(MLIR_bb0_DIR_PATH, basename + '.mlir')
        log_file = open(os.path.join(LOGS_DIR_PATH, basename + '_bb0_extract.log'), 'w')
        extract_bb0(input_file, output_file, log_file)

    LAKE_file2ret = dict()
    # Run the lean pass in parallel
    LAKE_compile_riscv64(jobs, LAKE_file2ret)

    XDSL_remove_casts_file2ret = dict()
    # Remove unrealized casts 
    for filename in os.listdir(LEANMLIR_ASM_DIR_PATH):
        input_file = os.path.join(LEANMLIR_ASM_DIR_PATH, filename)
        if LAKE_file2ret[input_file] == 0: 
            basename, _ = os.path.splitext(filename)
            output_file = os.path.join(XDSL_no_casts_DIR_PATH, basename + '.mlir')
            log_file = open(os.path.join(LOGS_DIR_PATH, basename + '_xdsl_remove_casts.log'), 'w')
            XDSL_remove_casts(input_file, output_file, log_file, XDSL_remove_casts_file2ret)

    XDSL_reg_alloc_file2ret = dict()
    for filename in os.listdir(XDSL_no_casts_DIR_PATH):
        input_file = os.path.join(XDSL_no_casts_DIR_PATH, filename)
        if XDSL_remove_casts_file2ret[input_file] == 0: 
            basename, _ = os.path.splitext(filename)
            output_file = os.path.join(XDSL_reg_alloc_DIR_PATH, basename + '.mlir')
            log_file = open(os.path.join(LOGS_DIR_PATH, basename + '_xdsl_reg_alloc.log'), 'w')
            XDSL_reg_alloc(input_file, output_file, log_file, XDSL_reg_alloc_file2ret)

    XDSL_riscv_file2ret = dict()
    # Compile to RISCV asm with XDSL 
    for filename in os.listdir(XDSL_reg_alloc_DIR_PATH):
        input_file = os.path.join(XDSL_reg_alloc_DIR_PATH, filename)
        if XDSL_reg_alloc_file2ret[input_file] == 0: 
            basename, _ = os.path.splitext(filename)
            output_file = os.path.join(XDSL_ASM_DIR_PATH, basename + '.s')
            log_file = open(os.path.join(LOGS_DIR_PATH, basename + '_xdsl_riscv.log'), 'w')
            XDSL_compile_riscv(input_file, output_file, log_file, XDSL_riscv_file2ret)


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
