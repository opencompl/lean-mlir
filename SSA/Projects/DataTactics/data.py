#!/usr/bin/env python3

import os
import subprocess
import tempfile
import shutil

directory = 'SSA/Projects/InstCombine/tests/LLVM/'
def remove_warning_lines(input_string):
    # Split the input string into lines
    lines = input_string.split('\n')

    # Filter out lines that start with "warning:"
    filtered_lines = [
        line for line in lines
        if not line.strip().lower().startswith("warning:")
        and not line.strip().lower().startswith("trace:")
        and not line.strip().lower().startswith("note:")
        and not line.strip().lower().startswith("- SSA.Projects.InstCombine.tests.LLVM")
    ]

    # Join the filtered lines back into a single string
    result = '\n'.join(filtered_lines)

    return result
def process_file(file_name):
    # Create a temporary file
    file_path = directory + file_name
    temp_file_path = directory + "temp/" + file_name
    with open(file_path, 'r') as input_file, open(temp_file_path, "w") as temp_file:
        content = input_file.read()
        modified_content = content.replace('sorry', 'print_lctx ; all_goals (sorry)')
        modified_content = "import SSA.Projects.DataTactics.alex\n" + modified_content
        temp_file.write(modified_content)

        # for line in input_file:
        #     temp_file.write(line.replace('sorry', 'assert_bitwise_tactic'))

    # with tempfile.NamedTemporaryFile(mode='w', delete=False, suffix='.lean') as temp_file:
    #     temp_file_path = temp_file.name

    #     # Read the original file and replace 'sorry' with 'assert_bitwise_tactic'
    #     with open(file_path, 'r') as original_file:
    #         content = original_file.read()
    #         modified_content = content.replace('sorry', 'assert_bitwise_tactic')
    #         content = "import Data.SSA.Projects.DataTactics.alex\n" + content
    #         temp_file.write(modified_content)

    # try:
    # Run 'lean build' on the templeanorary file
    module = temp_file_path.replace("/", ".")[:-5]
    result = subprocess.run(['lake', 'build', module], capture_output=True, text=True)
    print(f"result = {result}")
    print(f"stdout = {result.stdout}")
    stdout = remove_warning_lines(result.stdout)
    stdout = "\n".join(stdout.split("\n")[2:])
    stdout = stdout.replace("SSA/Projects/InstCombine/tests/LLVM", "")
    stdout = stdout.replace("error: Lean exited with code 1","")
    stdout = stdout.replace("Some builds logged failures:","")
    stdout = stdout.replace("./././", "")

    # Append output to log.txt
    with open('SSA/Projects/DataTactics/names_log.txt', 'a') as log_file:
        log_file.write(f"File: {file_path}\n")
        log_file.write(stdout)
        # log_file.write(stderr)
        log_file.write("\n" + "_"*50 + "\n")

    os.unlink(temp_file_path)

def main():
    # Iterate over all files in the directory
    for filename in os.listdir(directory):
        if filename.endswith('_proof.lean'):
            file_path = os.path.join(directory, filename)
            process_file(filename)

if __name__ == "__main__":
    main()
