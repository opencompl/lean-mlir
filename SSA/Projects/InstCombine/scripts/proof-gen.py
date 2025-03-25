#!/usr/bin/env python3
import re
import os
import subprocess
from multiprocessing import Pool
from cfg import *


def get_lines(msg):
    # Define the regex pattern to match error messages with line numbers
    pattern = re.compile(r"info: .+?:(\d+):\d+: (theorem extracted.+?)(?=warning)", flags=re.DOTALL)
    # Find all matches in the log
    matches = pattern.findall(msg)
    lines_thm = [(int(l), m) for (l, m) in matches if "no goals to be solved" not in m]
    # Replace this with your actual implementation
    return lines_thm


def gen_proof(thm):
    return thm.replace(
        "sorry\n",
        """by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry\n
""",
    )


def gen_intro(stem):
    return f"""
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false
set_option Elab.async false

section {stem}_proof
"""


def print_log(log, log_file):
    with open(log_file, "a+") as l:
        l.writelines(log)


def process_file(file_path):
    # Run the `lake build` command and capture the output
    module_name = file_path[:-5].replace("/", ".")
    proof_file = file_path[:-5].replace("/LLVM/", "/proofs/") + "_proof.lean"
    stem_name = file_path.split("/")[-1][:-5]
    new_file_path = file_path.replace("/LLVM/", "/proofs/")
    log_path = proof_file.replace("/proofs/", "/logs/proofs/").replace(".lean", ".txt")
    result = subprocess.run(
        ["lake", "build", module_name], capture_output=True, text=True
    )
    print(result)
    msg = result.stdout
    if result.stderr:
        print_log([result.stdout, result.stderr], log_path)
        return
    print(f"msg = {msg}")

    # Get the lines to replace and append
    lines_to_replace = get_lines(msg)

    # Read the file content
    with open(file_path, "r") as file:
        lines = file.readlines()

    # # Replace the specified lines

    named = [(l, lines[l - 2][11:-1], m) for (l, m) in lines_to_replace]
    for l, n, m in named:
        if 0 <= l - 1 < len(lines):
            lines[l - 1] = f"  apply {n}_thm\n"

    for i, line in enumerate(lines):
        if line == "  all_goals (try extract_goal ; sorry)":
            lines[i] = "  done\n"

    lines[0] = f"import SSA.Projects.InstCombine.tests.proofs.{stem_name}_proof\n"
    # Write the modified content to the new file
    with open(new_file_path, "w") as file:
        file.writelines(lines)

    # Append the messages to the end of the file
    with open(proof_file, "w") as file:
        file.write(gen_intro(stem_name))
        for _, n, m in named:
            print(f"m = {m}")
            print(f"n = {n}")
            thm = m.replace("extracted_1", n + "_thm")
            thm = gen_proof(thm)
            print(thm)
            file.write(thm + "\n")


def main():
    rm_proofs = "\nrm -r " + proof_path + "/*\n"
    subprocess.run(rm_proofs, shell=True)
    
    rm_logs = "\nrm -r " + proof_log_path + "/*\n"
    subprocess.run(rm_logs, shell=True)


    worklist = []
    for root, _, files in os.walk(test_path):
        for lean_file in files:
            if lean_file.endswith(".lean"):  # Assuming the files have a .lean extension
                file_path = os.path.join(root, lean_file)
                print(file_path)
                worklist.append(file_path)
    print(f"worklist = {worklist}")
    with Pool(200) as p:
        p.map(process_file, worklist)


if __name__ == "__main__":
    main()
