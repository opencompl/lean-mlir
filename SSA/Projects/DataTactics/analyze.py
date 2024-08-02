#!/usr/bin/env python3


import os
import subprocess
import tempfile
import shutil
from pandas import DataFrame, ExcelWriter
import re

# directory = 'SSA/Projects/InstCombine/tests/LLVM/'
def remove_warning_lines(input_string):
    # Split the input string into lines
    lines = input_string.split('\n')

    # Filter out lines that start with "warning:"
    filtered_lines = [
        line for line in lines
        if not line.strip().lower().startswith("warning:")
        and not line.strip().lower().startswith("trace:")
        and not line.strip().lower().startswith("note:")
        and not line.strip().lower().startswith("- ")
    ]

    # Join the filtered lines back into a single string
    result = '\n'.join(filtered_lines)

    return result
def process_file(file_path, tactics):
    with open(file_path, "r") as input_file:
        content = input_file.read()
    # Create a temporary file
    # file_path = directory + file_name
    names = []
    # res = []
    dfs = {}
    for i,t in enumerate(tactics):
        temp_file_path = file_path.replace(".lean", f"_{t}_temp.lean")
        dfs[t] = []
        with open(temp_file_path, "w") as temp_file:
            # modified_content = content.replace('sorry', 'print_lctx ; all_goals (sorry)')
            modified_content = content.replace('sorry', t)
            modified_content = "import SSA.Projects.DataTactics.alex\n" + modified_content
            temp_file.write(modified_content)
            # print(f"modified content = {modified_content}")
        # Run 'lean build' on the templeanorary file
        module = temp_file_path.replace("/", ".")[:-5]
        # print(f"module = {module}")
        result = subprocess.run(['lake', 'build', module], capture_output=True, text=True)
        # print(f"result = {result}")
        # print(f"stdout = {result.stdout}")
        stdout = remove_warning_lines(result.stdout)
        stdout = "\n".join(stdout.split("\n")[2:])
        stdout = stdout.replace("SSA/Projects/InstCombine/tests/LLVM", "")
        stdout = stdout.replace("error: Lean exited with code 1","")
        stdout = stdout.replace("Build completed successfully.\n","")
        stdout = stdout.replace("Some builds logged failures:","")
        stdout = stdout.replace("Some required builds logged failures:","")
        stdout = stdout.replace("./././", "")
        stdout = re.sub(r".*\[\d*/\d*\] Built .*\n", "", stdout)
        stdout = re.sub(r".*\[\d*/\d*\] Replayed .*\n", "", stdout)
        stdout = re.sub(r".*\[\d*/\d*\] Building .*\n", "", stdout)
        stdout = stdout.replace('(deterministic) timeout at `elaborator`, maximum number of heartbeats (200000) has been reached\nUse `set_option maxHeartbeats <num>` to set the limit.\nAdditional diagnostic information may be available by using the `set_option diagnostics true` command.', "")
        # print(f"stdout = {stdout}")
        lines = re.split(r"(info:|error:)", stdout)
        print(f"lines = {lines}")
        for line in lines:
            if line == '' or line == "error:" or line == "info:": continue
            print(f"line = {line}")
            (*name ,  msg ) = line.split(":")
            if i == 0:
                names.append("".join(name))
            # e content = input_file.read()
            # res.append(msg.strip())
            dfs[t].append(msg.strip())
    print(dfs)
    df = DataFrame({'name': names, **dfs })
    # Append output to log.txt
    # with open('SSA/Projects/DataTactics/names_log.txt', 'a') as log_file:
    #     log_file.write(f"File: {file_path}\n")
    #     log_file.write(stdout)
    #     # log_file.write(stderr)
    #     log_file.write("\n" + "_"*50 + "\n")

    os.unlink(temp_file_path)
    return df


def analyze_files(file_paths, tactics, output_file = None, summary_file = None):
    stdouts = []
    theorems = 0
    not_equalities = 0
    unsupported_operations  =0
    succeeded = 0
    with ExcelWriter('test.xlsx') as writer:
        for lean_file in file_paths:
            # open(lean_file, 'r') as input_file,
            stdout = process_file(lean_file, tactics)
            print(stdout)
            *a, sheet_name = lean_file.split("/")
            stdout.to_excel(writer, sheet_name=sheet_name, index=True)
            theorems += len(stdout)
            # s  = stdout.apply(lambda c : c.str.contains("found something else")  , axis = 0)]
            # print(f"s = {s}")
            not_equalities += stdout[stdout.apply(lambda c : c.str.contains("found something else"))].count()
            unsupported_operations += stdout[stdout.apply(lambda c : c.str.contains("is not"))].count()
            succeeded += stdout[stdout.apply(lambda c :c.str.contains("succeeded"))].count()
            print(not_equalities)
            print(unsupported_operations)
            # stdout.append(stdout)
        DataFrame({
             "theorems": theorems,
             "theorems failed due to not being an equality": not_equalities,
             "theorems failed due to unsupported operations": unsupported_operations,
             "theorems succeeded": succeeded
         }).to_excel(writer ,sheet_name = "summary", index=True)

    # df = DataFrame({'File Path': file_paths, 'stdout': l2})
