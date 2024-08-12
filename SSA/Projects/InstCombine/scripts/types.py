#!/usr/bin/env python3
import re
import os
import subprocess
from multiprocessing import Pool


def get_lines(msg):
    # Define the regex pattern to match error messages with line numbers
    pattern = re.compile(r"info: .+?:(\d+):\d+: (.+?)(?=warning)", flags=re.DOTALL)
    # Find all matches in the log
    matches = pattern.findall(msg)
    lines = [(int(l), m) for (l, m) in matches if "no goals to be solved" not in m]
    # Replace this with your actual implementation
    return lines
    # return [(1, "New message for line 1"), (3, "New message for line 3")]


def process_file(file_path):
    # Run the `lake build` command and capture the output
    module_name = file_path[2:-5].replace("/", ".")
    proof_name = file_path[:-5] + "_proof"
    stem_name = file_path.split("/")[-1][:-5]
    result = subprocess.run(
        ["lake", "build", module_name], capture_output=True, text=True
    )
    msg = result.stdout
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
            lines[l - 1] = f"  apply {n}_thm" + "\n"
    lines[0] = f"import SSA.Projects.InstCombine.tests.LLVM.{stem_name}_proof\n"
    # Write the modified content back to the file
    with open(file_path, "w") as file:
        file.writelines(lines)

    # Append the messages to the end of the file
    with open(proof_name + ".lean", "a") as file:
        file.write(
            """
open Std (BitVec)
"""
        )
        for _, n, m in named:
            print(f"m = {m}")
            print(f"n = {n}")
            thm = m.replace("extracted_1", n + "_thm")
            print(thm)
            file.write(thm + "\n")


def main():
    directory = "./SSA/Projects/InstCombine/test/LLVM"
    worklist = []
    for root, _, files in os.walk(directory):
        for lean_file in files:
            if lean_file.endswith(".lean"):  # Assuming the files have a .lean extension
                file_path = os.path.join(root, lean_file)
                print(file_path)
                worklist.append(file_path)

    with Pool(5) as p:
        p.map(process_file, worklist)


if __name__ == "__main__":
    main()
