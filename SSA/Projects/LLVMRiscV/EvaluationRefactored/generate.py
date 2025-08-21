#!/usr/bin/env python3

import sys
import os, shutil
import subprocess
import re 
import argparse

ROOT_DIR = (
    subprocess.check_output(["git", "rev-parse", "--show-toplevel"])
    .decode("utf-8")
    .strip()
)
TIMEOUT = 1800  # seconds

LLVM_BUILD_DIR = f"~/llvm-project/build/bin/"

LLVM_DIR = f"{ROOT_DIR}/SSA/Projects/LLVMRiscV/EvaluationRefactored/benchmarks/LLVM/"
LLVMIR_DIR = f"{ROOT_DIR}/SSA/Projects/LLVMRiscV/EvaluationRefactored/benchmarks/LLVMIR/"
MLIR_bb0_DIR = f"{ROOT_DIR}/SSA/Projects/LLVMRiscV/EvaluationRefactored/benchmarks/MLIR_bb0/"
MLIR_single_DIR = f"{ROOT_DIR}/SSA/Projects/LLVMRiscV/EvaluationRefactored/benchmarks/MLIR_single/"
MLIR_multi_DIR = f"{ROOT_DIR}/SSA/Projects/LLVMRiscV/EvaluationRefactored/benchmarks/MLIR_multi/"
LLC_ASM_DIR = f"{ROOT_DIR}/SSA/Projects/LLVMRiscV/EvaluationRefactored/benchmarks/LLC_ASM/"
LEANMLIR_ASM_DIR = f"{ROOT_DIR}/SSA/Projects/LLVMRiscV/EvaluationRefactored/benchmarks/LEANMLIR_ASM/"
LOGS_DIR = f"{ROOT_DIR}/SSA/Projects/LLVMRiscV/EvaluationRefactored/benchmarks/logs/"

def clear_folder (folder):
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
            print('Failed to delete %s. Reason: %s' % (file_path, e))

def run_command (cmd, log_file, timeout=TIMEOUT): 
    try:
        print(cmd)
        subprocess.Popen(
            cmd, cwd=ROOT_DIR, stdout=log_file, stderr=log_file, shell=True
        ).wait(timeout=timeout)
    except subprocess.TimeoutExpired:
            log_file.truncate(0)
            log_file.write(f"timeout of {timeout} seconds reached\n")
            print(f"{log_file} - timeout of {timeout} seconds reached")

def extract_mlir_blocks (input_file, output_base, max_functions):
    """
    Extracts individual MLIR module blocks (functions) from a large input file
    and saves each into a separate file.
    """
    try:
        with open(input_file, 'r') as f:
            content = f.read()
    except FileNotFoundError:
        print(f"Error: Input file '{input_file}' not found. ")
        return
    except Exception as e:
        print(f"Error reading input file: {e}")
        return

    delimiter_pattern = r'\n// -{5,}.*?\n'
    blocks = re.split(delimiter_pattern, content, flags=re.DOTALL)

    function_count = 0
    for i, block_content in enumerate(blocks):
        if function_count >= max_functions:
            print(f"Reached maximum of {max_functions} functions. Stopping extraction.")
            break

        clean_block = block_content.strip()

        if clean_block and 'module {' in clean_block:
            original_mlir_filename = os.path.join(output_base, f"function_{function_count}.mlir")
            try:
                with open(original_mlir_filename, 'w') as out_f:
                    out_f.write(clean_block)
                    out_f.write('\n')
                print(f"Extracted function {function_count} to '{original_mlir_filename}'")
                function_count += 1
            except Exception as e:
                print(f"Error writing to file or during transformation: {e}")
                # Continue trying to extract other functions even if one fails
                continue

def MLIR_opt_arith_llvm (idx):
    """
    Run mlir-opt and convert a file into LLVM dialect.
    """
    input_file = MLIR_single_DIR+"function_"+str(idx)+".mlir"
    output_file = LLVM_DIR+"function_"+str(idx)+".ll"
    log_file = open(LOGS_DIR+"mlir_opt_"+str(idx)+".log","w")
    print(f"Converting '{input_file}' to LLVM dialect in {output_file} ")
    cmd_base = "mlir-opt -convert-arith-to-llvm -convert-func-to-llvm --mlir-print-op-generic "
    cmd = LLVM_BUILD_DIR + cmd_base + input_file + " -o " + output_file
    run_command(cmd, log_file)

def MLIR_translate_llvmir (idx):
    """
    Run mlir-translate and translate a file from LLVM dialect to LLVMIR.
    """
    input_file = LLVM_DIR+"function_"+str(idx)+".ll"
    output_file = LLVMIR_DIR+"function_"+str(idx)+".mlir"
    log_file = open(LOGS_DIR+"mlir_translate_"+str(idx)+".log","w")
    print(f"Compiling '{input_file}' to LLVM IR. ")
    cmd_base = "mlir-translate --mlir-to-llvmir "
    cmd = LLVM_BUILD_DIR + cmd_base + input_file + " -o " + output_file
    run_command(cmd, log_file)


def LLC_compile_riscv (idx):
    """
    Compile LLVMIR to RISCV assembly with llc.
    """
    input_file = LLVMIR_DIR+"function_"+str(idx)+".mlir"
    output_file = LLC_ASM_DIR+"function_"+str(idx)+".s"
    log_file = open(LOGS_DIR+"llc_"+str(idx)+".log","w")
    print(f"Compiling '{input_file}' to RISC-V assembly using llc.")
    cmd_base = LLVM_BUILD_DIR + "llc -march=riscv64 -mcpu=generic-rv64 -mattr=+m,+b -filetype=asm -O0 "
    cmd = cmd_base + input_file + " -o " + output_file
    run_command(cmd, log_file)

def extract_bb0 (idx):
    """
    Extract the first basic block from the MLIR file.
    """
    input_file = LLVM_DIR+"function_"+str(idx)+".ll"
    output_file = MLIR_bb0_DIR+"function_"+str(idx)+".mlir"
    o_f = open(output_file, "w")
    in_block = False
    try:
        with open(input_file, 'r') as f:
            for line in f:
                line = line.strip()
                if line.startswith('^bb0('):
                    in_block = True
                    o_f.write('{\n')
                    o_f.write(line+'\n')
                    continue
                if in_block:
                    o_f.write(line+'\n')
                    if '"llvm.return"' in line:
                        o_f.write('}'+'\n')
                        o_f.close()
                        return

    except FileNotFoundError:
        print(f"Error: The file '{input_file}' was not found.", file=sys.stderr)
        sys.exit(1)

def LAKE_compile_riscv64 (idx):
    """
    Lower the input file to RISCV with Lean-MLIR
    """
    input_file = MLIR_bb0_DIR+"function_"+str(idx)+".mlir"
    output_file = LEANMLIR_ASM_DIR+"function_"+str(idx)+".mlir"
    log_file = open(LOGS_DIR+"lake_"+str(idx)+".mlir","w")
    print(f"Compiling '{input_file}' to RISC-V assembly in Lean-MLIR..")
    cmd_base = "cd; cd lean-mlir; lake exe opt --passriscv64 "
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

def clear_empty_logs():
    """
    Only leave in the logs folder the files that contain something.
    """
    for filename in os.listdir(LOGS_DIR):
        file_path = os.path.join(LOGS_DIR, filename)
        if os.path.getsize(file_path) == 0:
            try:
                if os.path.isfile(file_path) or os.path.islink(file_path):
                    os.unlink(file_path)
                elif os.path.isdir(file_path):
                    shutil.rmtree(file_path)
            except Exception as e:
                print('Failed to delete {filename}')

def generate_benchmarks(file_name, num): 
    # extract mlir blocks and put them all in separate files 
    clear_folders()
    input_file = MLIR_multi_DIR + file_name

    extract_mlir_blocks(input_file, MLIR_single_DIR, num)

    for i in range(num) : 
        print(i)
        # Run mlir-opt and convert into LLVM dialect 
        MLIR_opt_arith_llvm(i)
        # Run mlir-translate and convert LLVM into LLVMIR
        MLIR_translate_llvmir(i)
        # Use llc to compile LLVMIR into RISCV
        LLC_compile_riscv(i)
        # Extract bb0
        extract_bb0(i)
        # Compile with Lean-MLIR
        LAKE_compile_riscv64(i)

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
        help="Name of the file containing the functions to lower. "
    )
    parser.add_argument(
        "-n", 
        "--num", 
        type=int, 
        default=100, 
        help="Number of benchmarks to generate. "
    )

    args = parser.parse_args()
    generate_benchmarks(args.input, args.num)

if __name__ == "__main__":
    main()