import sys
import os 

ROOT_DIR = (
    subprocess.check_output(["git", "rev-parse", "--show-toplevel"])
    .decode("utf-8")
    .strip()
)

LLVM_DIR = f"{ROOT_DIR}/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/LLVM/"
LLVMIR_DIR = f"{ROOT_DIR}/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/LLVMIR/"
MLIR_DIR = f"{ROOT_DIR}/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/MLIR/"
ASM_DIR = f"{ROOT_DIR}/SSA/Projects/LLVMRiscV/Evaluation/benchmarks/ASM/"


def LLVMIR_to_MLIR (input_file_path, output_file_path, log_file_path, timeout = TIMEOUT): 
    """Translate LLVM IR to MLIR""" 
    cmd = "mlir-translate -import-llvm"
    with open(log_file_path, "w") as log_file:
        cmd = cmd_prefix + input_file_path + " > " + output_file_path
        print(f"Running: {cmd}")
        try:
            subprocess.Popen(
                cmd, cwd=ROOT_DIR, stdout=log_file, stderr=log_file, shell=True
            ).wait(timeout=timeout)
        except subprocess.TimeoutExpired:
            log_file.truncate(0)
            log_file.write(f"timeout of {timeout} seconds reached\n")
            print(f"{file_to_run} - timeout of {timeout} seconds reached")


def extract_basic_block(file_path):
    """
    Extract the first basic block from the MLIR file.
    """
    in_block = False
    
    try:
        with open(file_path, 'r') as f:
            for line in f:
                line = line.strip()
                if line.startswith('^bb0('):
                    in_block = True
                    print('{')
                    print(line)
                    continue
                if in_block:
                    print(line)
                    if '"llvm.return"' in line:
                        print('}')
                        sys.exit(0)

    except FileNotFoundError:
        print(f"Error: The file '{file_path}' was not found.", file=sys.stderr)
        sys.exit(1)

# 2. optimize: `mlir-opt --mlir-print-op-generic "$INPUT_FILE"`
# 3. extract the first basic block: `extractbb0.sh $INPUT_FILE > ${OUT_MLIR}`
# 4. `lake exe opt --passriscv64 SSA/Projects/LLVMRiscV/tests/LLVMIR/${OUT_MLIR} > SSA/Projects/LLVMRiscV/tests/LLVMIR/${OUT1_MLIR}`
