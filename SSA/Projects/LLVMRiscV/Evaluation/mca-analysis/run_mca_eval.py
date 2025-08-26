#this script is intended to be run after having run the run_mca.py script to analyse
# the result and it relies on the directories created by run_mca.py.

import subprocess
import os
import re
import csv
from pathlib import Path

ROOT_DIR_PATH = (
    subprocess.check_output(["git", "rev-parse", "--show-toplevel"])
    .decode("utf-8")
    .strip()
)

LLVMIR_DIR_PATH = (
    # f"{ROOT_DIR_PATH}/SSA/Projects/LLVMRiscV/Evaluation/mca-analysis/LLVM/"
    f"{ROOT_DIR_PATH}/SSA/Projects/LLVMRiscV/Evaluation/mca-analysis/results/LLVM/"
)
LLVM_GLOBALISEL_DIR_PATH = (
    f"{ROOT_DIR_PATH}/SSA/Projects/LLVMRiscV/Evaluation/mca-analysis/results/LLVM_GLOBALISEL/"
)
LEANMLIR_DIR_PATH = (
    f"{ROOT_DIR_PATH}/SSA/Projects/LLVMRiscV/Evaluation/mca-analysis/results/Lean-MLIR/"
)
LLVMIR_TABLE_DIR_PATH = (
    f"{ROOT_DIR_PATH}/SSA/Projects/LLVMRiscV/Evaluation/mca-analysis/results/LLVM_table/"
)
LLVM_GLOBALISEL_TABLE_DIR_PATH = (
        f"{ROOT_DIR_PATH}/SSA/Projects/LLVMRiscV/Evaluation/mca-analysis/results/LLVM_GLOBALISEL_table/"
)
LEANMLIR_TABLE_DIR_PATH = (
    f"{ROOT_DIR_PATH}/SSA/Projects/LLVMRiscV/Evaluation/mca-analysis/results/Lean-MLIR_table/"
)


def create_missing_table_folders(): 
    if not os.path.exists(LLVMIR_TABLE_DIR_PATH):
        os.makedirs(LLVMIR_TABLE_DIR_PATH)
    if not os.path.exists(LLVM_GLOBALISEL_TABLE_DIR_PATH):
        os.makedirs(LLVM_GLOBALISEL_TABLE_DIR_PATH)
    if not os.path.exists(LEANMLIR_TABLE_DIR_PATH):
        os.makedirs(LEANMLIR_TABLE_DIR_PATH)

def write_csv(rows, out_dir, filename):
    out_dir = Path(out_dir)
    csv_path = out_dir / filename
    with csv_path.open("w", newline="") as f:
        writer = csv.writer(f)
        writer.writerow(["File", "Instructions"])
        for name, val in rows:
            writer.writerow([name, "" if val == "—" else val])
    return csv_path

def iterate_files_in_directory(directory, out_directory):
    instr = re.compile(r"Instructions:\s*([0-9]+)")  #get number of instr.
    rows = []
    for filename in os.listdir(directory):
        file_path = os.path.join(directory, filename)
        if not os.path.isfile(file_path):
            continue #we skip if its not a file
        pair = "-" # garabage value 
        try:
            with open(file_path, "r") as f:
                for line in f:
                    pair = instr.search(line)
                    if pair:
                        instr_val = pair.group(1)
                        print(f"{filename}: {instr_val}")
                        break #we know this is valid given the structure of the mca output
        except Exception as e:
            print(f"Error reading {file_path}: {e}")
        
        rows.append((filename, instr_val))
    filenametobe = os.path.basename(os.path.normpath(directory))
    write_csv(rows, out_directory,filenametobe) 

if __name__ == "__main__":
    create_missing_table_folders()
    iterate_files_in_directory(LLVMIR_DIR_PATH,LLVMIR_TABLE_DIR_PATH)
    iterate_files_in_directory(LLVM_GLOBALISEL_DIR_PATH,LLVM_GLOBALISEL_TABLE_DIR_PATH)
    iterate_files_in_directory(LEANMLIR_DIR_PATH,LEANMLIR_TABLE_DIR_PATH)