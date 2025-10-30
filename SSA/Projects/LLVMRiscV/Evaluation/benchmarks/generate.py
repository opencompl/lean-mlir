#!/usr/bin/env python3

import sys
import os
import shutil
import subprocess
import re
import argparse
import concurrent.futures


ROOT_DIR_PATH = (
    subprocess.check_output(["git", "rev-parse", "--show-toplevel"])
    .decode("utf-8")
    .strip()
)

TIMEOUT_SEC = 1800

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
LLC_ASM_selectiondag_DIR_PATH = f"{ROOT_DIR_PATH}/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/LLC_ASM_selectiondag/"
LLC_ASM_globalisel_DIR_PATH = (
    f"{ROOT_DIR_PATH}/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/LLC_ASM_globalisel/"
)
LEANMLIR_ASM_DIR_PATH = (
    f"{ROOT_DIR_PATH}/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/LEANMLIR_ASM/"
)
LEANMLIR_ASM_opt_DIR_PATH = (
    f"{ROOT_DIR_PATH}/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/LEANMLIR_ASM_opt/"
)
XDSL_ASM_DIR_PATH = (
    f"{ROOT_DIR_PATH}/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/XDSL_ASM/"
)
XDSL_opt_ASM_DIR_PATH = (
    f"{ROOT_DIR_PATH}/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/XDSL_opt_ASM/"
)
XDSL_FUNC_ASM_DIR_PATH = (
    f"{ROOT_DIR_PATH}/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/XDSL_FUNC/"
)
XDSL_FUNC_opt_ASM_DIR_PATH = (
    f"{ROOT_DIR_PATH}/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/XDSL_FUNC_opt/"
)
LOGS_DIR_PATH = f"{ROOT_DIR_PATH}/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/logs/"


AUTOGEN_DIR_PATHS = [
    LLVM_DIR_PATH,
    LLVMIR_DIR_PATH,
    MLIR_bb0_DIR_PATH,
    MLIR_single_DIR_PATH,
    LLC_ASM_selectiondag_DIR_PATH,
    LLC_ASM_globalisel_DIR_PATH,
    XDSL_FUNC_ASM_DIR_PATH,
    XDSL_FUNC_opt_ASM_DIR_PATH,
    LEANMLIR_ASM_DIR_PATH,
    XDSL_ASM_DIR_PATH,
    LOGS_DIR_PATH,
    LEANMLIR_ASM_opt_DIR_PATH,
    XDSL_opt_ASM_DIR_PATH,
]


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


def replace_hyphens_in_variables(file_path):
    """
    Reads a file, replaces hyphens (-) with underscores (_) within
    MLIR variable names (starting with %), and overwrites the file.
    """

    if not os.path.exists(file_path):
        print(f"Error: File not found at {file_path}")
        return

    pattern = r"(%[a-zA-Z0-9_-]+)"

    def variable_replacer(match):
        """Replace all hyphens with underscores in the matched variable name."""
        variable_name = match.group(0)
        if "-" in variable_name:
            return variable_name.replace("-", "_")
        return variable_name

    try:
        with open(file_path, "r") as f:
            original_content = f.read()

        modified_content = re.sub(pattern, variable_replacer, original_content)
        with open(file_path, "w") as f:
            f.write(modified_content)

    except IOError as e:
        print(f"Error processing file {file_path}: {e}")
    except Exception as e:
        print(f"An unexpected error occurred: {e}")


def run_command(cmd, log_file, timeout=TIMEOUT_SEC):
    try:
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
    f = open(input_file, "r")
    all_lines = f.readlines()
    size = input_file.split("_")[-1].split(".")[0]
    function_count = 0
    curr_program = []
    brackets_count = 0
    for line in all_lines:
        if "{" in line:
            brackets_count += 1
        if brackets_count == 2:
            # remove indentation
            curr_program.append(line[2:])
        if "}" in line:
            brackets_count -= 1
        if brackets_count == 1 and len(curr_program) > 0:
            # write file
            out_f = open(output_base + f"{size}_function_{function_count}.mlir", "w")
            out_f.writelines(curr_program)
            out_f.write("\n")
            out_f.close()
            curr_program = []
            function_count += 1
            curr_program = []
        if function_count >= max_functions:
            print(f"Reached maximum of {max_functions} functions. Stopping extraction.")
            break


def MLIR_opt_arith_llvm(input_file, output_file, log_file, pass_dict):
    """
    Run mlir-opt and convert a file into LLVM dialect.
    """
    cmd_base = (
        "mlir-opt -convert-arith-to-llvm -convert-func-to-llvm --mlir-print-op-generic "
    )
    cmd = cmd_base + input_file + " -o " + output_file
    ret_code = run_command(cmd, log_file)
    pass_dict[output_file] = ret_code


def MLIR_translate_llvmir(input_file, output_file, log_file, pass_dict):
    """
    Run mlir-translate and translate a file from LLVM dialect to LLVMIR.
    """
    cmd_base = "mlir-translate --mlir-to-llvmir "
    cmd = cmd_base + input_file + " -o " + output_file
    ret_code = run_command(cmd, log_file)
    pass_dict[output_file] = ret_code


def LLC_compile_riscv_selectiondag(input_file, output_file, log_file, pass_dict, opt):
    """
    Compile LLVMIR to RISCV assembly with llc.
    """
    cmd_base = (
        "llc -march=riscv64 -mcpu=generic-rv64 -mattr=+m,+b -filetype=asm " + opt + " "
    )
    cmd = cmd_base + input_file + " -o " + output_file
    ret_code = run_command(cmd, log_file)
    pass_dict[output_file] = ret_code


def LLC_compile_riscv_globalisel(input_file, output_file, log_file, pass_dict, opt):
    """
    Compile LLVMIR to RISCV assembly with llc using the GlobalISel framework.
    """
    cmd_base = (
        "llc -march=riscv64 -mcpu=generic-rv64 --global-isel -mattr=+m,+b -filetype=asm "
        + opt
        + " "
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
                if "^bb0(" in line:
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
            output_file = os.path.join(LEANMLIR_ASM_DIR_PATH, basename + ".mlir")
            log_file = open(LOGS_DIR_PATH + basename + "_lake.mlir", "w")
            cmd_base = f"cd {ROOT_DIR_PATH}; lake exe opt --passriscv64 "
            cmd = cmd_base + input_file + " > " + output_file
            future = executor.submit(run_command, cmd, log_file)
            futures[future] = output_file

        total = len(futures)
        for idx, future in enumerate(concurrent.futures.as_completed(futures)):
            file_path = futures[future]
            ret_code = future.result()
            pass_dict[file_path] = ret_code
            percentage = (float(idx) / float(total)) * 100
            print(f"compiling with lean-mlir {percentage:.2f}%")


def LAKE_compile_riscv64_opt(jobs, pass_dict):
    """
    Lower the input file to RISCV with Lean-MLIR, using multiple threads.
    """
    with concurrent.futures.ThreadPoolExecutor(max_workers=jobs) as executor:
        futures = {}

        for filename in os.listdir(MLIR_bb0_DIR_PATH):
            input_file = os.path.join(MLIR_bb0_DIR_PATH, filename)
            basename, _ = os.path.splitext(filename)
            output_file = os.path.join(LEANMLIR_ASM_opt_DIR_PATH, basename + ".mlir")
            log_file = open(LOGS_DIR_PATH + basename + "_lake.mlir", "w")
            cmd_base = f"cd {ROOT_DIR_PATH}; lake exe opt --passriscv64_optimized "
            cmd = cmd_base + input_file + " > " + output_file
            future = executor.submit(run_command, cmd, log_file)
            futures[future] = output_file

        total = len(futures)
        for idx, future in enumerate(concurrent.futures.as_completed(futures)):
            file_path = futures[future]
            ret_code = future.result()
            pass_dict[file_path] = ret_code
            percentage = (float(idx) / float(total)) * 100
            print(f"compiling with lean-mlir (optimized pass): {percentage:.2f}%")


def XDSL_create_func(input_file, output_file, log_file, pass_dict):
    """
    Remove unrealized casts from the RISCV64 dialect MLIR files with xdsl.
    """
    cmd_base = f"python3 {ROOT_DIR_PATH}/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/create_func.py "
    cmd = cmd_base + input_file + " > " + output_file
    ret_code = run_command(cmd, log_file)
    pass_dict[output_file] = ret_code


def XDSL_reg_alloc(input_file, output_file, log_file, pass_dict):
    """
    Remove unrealized casts from the RISCV64 dialect MLIR files with xdsl.
    """
    cmd_base = "xdsl-opt -p convert-func-to-riscv-func,reconcile-unrealized-casts,riscv-allocate-registers -t riscv-asm "
    cmd = cmd_base + input_file + " > " + output_file
    ret_code = run_command(cmd, log_file)
    pass_dict[output_file] = ret_code


def generate_benchmarks(num, jobs, llvm_opts):
    setup_benchmarking_directories()

    # extract mlir blocks and put them all in separate files
    # for each file with programs of a certain size
    for file in os.listdir(MLIR_multi_DIR_PATH):
        input_file = os.path.join(MLIR_multi_DIR_PATH, file)
        replace_hyphens_in_variables(input_file)
        extract_mlir_blocks(input_file, MLIR_single_DIR_PATH, num)

    MLIR_opt_file2ret = dict()
    idx = 0
    # Run mlir-opt and convert into LLVM dialect
    for filename in os.listdir(MLIR_single_DIR_PATH):
        input_file = os.path.join(MLIR_single_DIR_PATH, filename)
        basename, _ = os.path.splitext(filename)
        output_file = os.path.join(LLVM_DIR_PATH, basename + ".ll")
        log_file = open(os.path.join(LOGS_DIR_PATH, basename + "_mlir_opt.log"), "w")
        MLIR_opt_arith_llvm(input_file, output_file, log_file, MLIR_opt_file2ret)
        idx += 1
        percentage = (float(idx) / float(len(os.listdir(MLIR_single_DIR_PATH)))) * 100
        print(f"translating to LLVM with mlir-opt: {percentage:.2f}%")

    MLIR_translate_file2ret = dict()
    idx = 0
    # Run mlir-translate and convert LLVM into LLVMIR
    for filename in os.listdir(LLVM_DIR_PATH):
        input_file = os.path.join(LLVM_DIR_PATH, filename)
        # only run the lowering if the previous pass was successful:
        if MLIR_opt_file2ret[input_file] == 0:
            basename, _ = os.path.splitext(filename)
            output_file = os.path.join(LLVMIR_DIR_PATH, basename + ".mlir")
            log_file = open(
                os.path.join(LOGS_DIR_PATH, basename + "_mlir_translate.log"), "w"
            )
            MLIR_translate_llvmir(
                input_file, output_file, log_file, MLIR_translate_file2ret
            )
        idx += 1
        percentage = (float(idx) / float(len(MLIR_opt_file2ret))) * 100
        print(f"translating to LLVMIR with mlir-translate: {percentage:.2f}%")

    for llvm_opt in llvm_opts:
        LLC_file2ret = dict()
        idx = 0
        # Use llc with `selectionDAG` to compile LLVMIR into RISCV
        for filename in os.listdir(LLVMIR_DIR_PATH):
            input_file = os.path.join(LLVMIR_DIR_PATH, filename)
            # only run the lowering if the previous pass was successful:
            if MLIR_translate_file2ret[input_file] == 0:
                basename, _ = os.path.splitext(filename)

                if llvm_opt == "default":
                    output_file = os.path.join(
                        LLC_ASM_selectiondag_DIR_PATH, basename + ".s"
                    )
                    log_file = open(
                        os.path.join(LOGS_DIR_PATH, basename + "_selectiondag_llc.log"),
                        "w",
                    )
                    LLC_compile_riscv_selectiondag(
                        input_file, output_file, log_file, LLC_file2ret, ""
                    )
                else:
                    output_file = os.path.join(
                        LLC_ASM_selectiondag_DIR_PATH, basename + "_" + llvm_opt + ".s"
                    )
                    log_file = open(
                        os.path.join(
                            LOGS_DIR_PATH,
                            basename + "_selectiondag_llc" + "_" + llvm_opt + ".log",
                        ),
                        "w",
                    )
                    LLC_compile_riscv_selectiondag(
                        input_file, output_file, log_file, LLC_file2ret, "-" + llvm_opt
                    )
            idx += 1
            percentage = (float(idx) / float(len(MLIR_translate_file2ret))) * 100
            print(f"compiling with llc (selectionDAG {llvm_opt}): {percentage:.2f}%")

        LLC_GLOBALISEL_file2ret = dict()
        idx = 0
        # Use llc with `GlobalISel` to compile LLVMIR into RISCV
        for filename in os.listdir(LLVMIR_DIR_PATH):
            input_file = os.path.join(LLVMIR_DIR_PATH, filename)
            # only run the lowering if the previous pass was successful:
            if MLIR_translate_file2ret[input_file] == 0:  # previous pass succeded
                if llvm_opt == "default":
                    basename, _ = os.path.splitext(filename)
                    output_file = os.path.join(
                        LLC_ASM_globalisel_DIR_PATH, basename + ".s"
                    )
                    log_file = open(
                        os.path.join(LOGS_DIR_PATH, basename + "_globalisel_llc.log"),
                        "w",
                    )
                    LLC_compile_riscv_globalisel(
                        input_file, output_file, log_file, LLC_GLOBALISEL_file2ret, ""
                    )
                else:
                    basename, _ = os.path.splitext(filename)
                    output_file = os.path.join(
                        LLC_ASM_globalisel_DIR_PATH, basename + "_" + llvm_opt + ".s"
                    )
                    log_file = open(
                        os.path.join(
                            LOGS_DIR_PATH,
                            basename + "_globalisel_llc" + "_" + llvm_opt + ".log",
                        ),
                        "w",
                    )
                    LLC_compile_riscv_globalisel(
                        input_file,
                        output_file,
                        log_file,
                        LLC_GLOBALISEL_file2ret,
                        "-" + llvm_opt,
                    )
            idx += 1
            percentage = (float(idx) / float(len(MLIR_translate_file2ret))) * 100
            print(f"compiling with llc (globalISel {llvm_opt}): {percentage:.2f}%")

    # Extract bb0
    idx = 0
    for filename in os.listdir(LLVM_DIR_PATH):
        input_file = os.path.join(LLVM_DIR_PATH, filename)
        basename, _ = os.path.splitext(filename)
        output_file = os.path.join(MLIR_bb0_DIR_PATH, basename + ".mlir")
        log_file = open(os.path.join(LOGS_DIR_PATH, basename + "_bb0_extract.log"), "w")
        extract_bb0(input_file, output_file, log_file)
        idx += 1
        percentage = (float(idx) / float(len(os.listdir(LLVM_DIR_PATH)))) * 100
        print(f"extracting the first basic block: {percentage:.2f}%")

    LAKE_file2ret = dict()
    # Run the lean pass in parallel
    LAKE_compile_riscv64(jobs, LAKE_file2ret)

    LAKE_file2ret_opt = dict()
    # Run the optimized lean pass in parallel
    LAKE_compile_riscv64_opt(jobs, LAKE_file2ret_opt)

    XDSL_create_func_file2ret = dict()
    idx = 0
    # Create `func.func`
    for filename in os.listdir(LEANMLIR_ASM_DIR_PATH):
        input_file = os.path.join(LEANMLIR_ASM_DIR_PATH, filename)
        if LAKE_file2ret[input_file] == 0:
            basename, _ = os.path.splitext(filename)
            output_file = os.path.join(XDSL_FUNC_ASM_DIR_PATH, basename + ".mlir")
            log_file = open(
                os.path.join(LOGS_DIR_PATH, basename + "_xdsl_create_func.log"), "w"
            )
            XDSL_create_func(
                input_file, output_file, log_file, XDSL_create_func_file2ret
            )
        idx += 1
        percentage = (float(idx) / float(len(LAKE_file2ret))) * 100
        print(f"creating func.func module: {percentage:.2f}%")

    XDSL_create_func_file2ret_opt = dict()
    idx = 0
    # Create `func.func`
    for filename in os.listdir(LEANMLIR_ASM_opt_DIR_PATH):
        input_file = os.path.join(LEANMLIR_ASM_opt_DIR_PATH, filename)
        if LAKE_file2ret_opt[input_file] == 0:
            basename, _ = os.path.splitext(filename)
            output_file = os.path.join(XDSL_FUNC_opt_ASM_DIR_PATH, basename + ".mlir")
            log_file = open(
                os.path.join(LOGS_DIR_PATH, basename + "_xdsl_create_func_opt.log"), "w"
            )
            XDSL_create_func(
                input_file, output_file, log_file, XDSL_create_func_file2ret_opt
            )
        idx += 1
        percentage = (float(idx) / float(len(LAKE_file2ret_opt))) * 100
        print(f"creating func.func module (opt): {percentage:.2f}%")

    XDSL_reg_alloc_file2ret = dict()
    idx = 0
    # Register allocation with XDSL
    for filename in os.listdir(XDSL_FUNC_ASM_DIR_PATH):
        input_file = os.path.join(XDSL_FUNC_ASM_DIR_PATH, filename)
        if XDSL_create_func_file2ret[input_file] == 0:
            basename, _ = os.path.splitext(filename)
            output_file = os.path.join(XDSL_ASM_DIR_PATH, basename + ".mlir")
            log_file = open(
                os.path.join(LOGS_DIR_PATH, basename + "_xdsl_reg_alloc.log"), "w"
            )
            XDSL_reg_alloc(input_file, output_file, log_file, XDSL_reg_alloc_file2ret)
        idx += 1
        percentage = (float(idx) / float(len(XDSL_create_func_file2ret))) * 100
        print(f"allocating registers and outputting assembly: {percentage:.2f}%")

    XDSL_reg_alloc_file2ret_opt = dict()
    idx = 0
    # Register allocation with XDSL
    for filename in os.listdir(XDSL_FUNC_opt_ASM_DIR_PATH):
        input_file = os.path.join(XDSL_FUNC_opt_ASM_DIR_PATH, filename)
        if XDSL_create_func_file2ret_opt[input_file] == 0:
            basename, _ = os.path.splitext(filename)
            output_file = os.path.join(XDSL_opt_ASM_DIR_PATH, basename + ".mlir")
            log_file = open(
                os.path.join(LOGS_DIR_PATH, basename + "_xdsl_reg_alloc.log"), "w"
            )
            XDSL_reg_alloc(
                input_file, output_file, log_file, XDSL_reg_alloc_file2ret_opt
            )
        idx += 1
        percentage = (float(idx) / float(len(XDSL_create_func_file2ret_opt))) * 100
        print(f"allocating registers and outputting assembly (opt): {percentage:.2f}%")


def main():
    parser = argparse.ArgumentParser(
        prog="generate",
        description="Generate a new set of benchmarks in all the representations, from MLIR to RISCV assembly.",
    )

    parser.add_argument(
        "-n", "--num", type=int, default=100, help="Number of benchmarks to generate. "
    )

    parser.add_argument(
        "-j", "--jobs", type=int, default=1, help="Parallel jobs for all benchmarks"
    )

    parser.add_argument(
        "-llvm",
        "--llvm_opt",
        help="Optimization level for LLVM.",
        nargs="+",
        choices=["O3", "O2", "O1", "O0", "default"],
        default="default",
    )

    args = parser.parse_args()

    opts_to_evaluate = (
        ["O3", "O2", "O1", "O0", "default"] if "all" in args.llvm_opt else args.llvm_opt
    )

    generate_benchmarks(args.num, args.jobs, opts_to_evaluate)


if __name__ == "__main__":
    main()
