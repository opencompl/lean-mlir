#!/usr/bin/env python3
import re
import os
import subprocess

log = """
warning: ././././SSA/Projects/InstCombine/AliveStatements.lean:813:8: declaration uses 'sorry'
✖ [2266/2266] Building SSA.Projects.InstCombine.lean.xor
trace: .> LEAN_PATH=././.lake/packages/batteries/home/atticusk/.elan/toolchains/leanprover--lean4---nightly-2024-07-11/bin/lean ././././SSA/Projects/InstCombine/lean/xor.lean -R ./././. -o ././.lake/build/lib/SSA/Projects/InstCombine/lean/xor.olean -i ././.lake/build/lib/SSA/Projects/InstCombine/lean/xor.ilean -c ././.lake/build/ir/SSA/Projects/InstCombine/lean/xor.c --json
error: ././././SSA/Projects/InstCombine/lean/xor.lean:49:2: no goals to be solved
error: ././././SSA/Projects/InstCombine/lean/xor.lean:77:2: no goals to be solved
error: ././././SSA/Projects/InstCombine/lean/xor.lean:105:2: no goals to be solved
error: ././././SSA/Projects/InstCombine/lean/xor.lean:133:2: no goals to be solved
error: ././././SSA/Projects/InstCombine/lean/xor.lean:163:2: no goals to be solved
error: ././././SSA/Projects/InstCombine/lean/xor.lean:194:2: ∀ (x : _root_.BitVec 32), (x ||| 123#32) ^^^ 123#32 = x &&& 4294967172#32
error: ././././SSA/Projects/InstCombine/lean/xor.lean:223:2: no goals to be solved
error: ././././SSA/Projects/InstCombine/lean/xor.lean:259:2: ∀ (x x_1 : _root_.BitVec 32), x_1 &&& 7#32 ^^^ x &&& 128#32 = x_1 &&& 7#32 ||| x &&& 128#32
error: ././././SSA/Projects/InstCombine/lean/xor.lean:752:2: ∀ (x : _root_.BitVec 32),
  (Option.bind (if 32 ≤ x.toNat then none else some ((4294967293#32).sshiftRight x.toNat)) fun a =>
      Option.bind (if 32 ≤ x.toNat then none else some (5#32 >>> x)) fun a_1 => some (a ^^^ a_1)) ⊑
    if 32 ≤ x.toNat then none else some ((4294967288#32).sshiftRight x.toNat)
error: Lean exited with code 1
Some builds logged failures:
- SSA.Projects.InstCombine.lean.xor
error: build failed
"""

# Print the results
# for line_number, message in lines:
#     print(f"Line {line_number}: {message}")

def get_lines(msg):
    # This is a placeholder for your actual get_lines function
    # Define the regex pattern to match error messages with line numbers
    pattern = re.compile(r'info: .+?:(\d+):\d+: (.+?)(?=warning)', flags=re.DOTALL)
    # Find all matches in the log
    matches = pattern.findall(msg)
    lines = [(int(l),m) for (l,m) in matches if "no goals to be solved" not in m]
    # Replace this with your actual implementation
    return lines
    # return [(1, "New message for line 1"), (3, "New message for line 3")]

def process_file(file_path):
    # Run the `lake build` command and capture the output
    module_name = file_path[2:-5].replace("/", ".")
    proof_name = file_path[:-5] + "_proof"
    stem_name = file_path.split("/")[-1][:-5]
    result = subprocess.run(['lake', 'build', module_name], capture_output=True, text=True)
    msg = result.stdout
    print(f"msg = {msg}")

    # Get the lines to replace and append
    lines_to_replace = get_lines(msg)

    # Read the file content
    with open(file_path, 'r') as file:
        lines = file.readlines()

    # # Replace the specified lines

    named = [
        (l,lines[l - 2][11:-1],m)
        for (l,m)
        in lines_to_replace
    ]
    for l, n,m in named:
        if 0 <= l - 1 < len(lines):
            lines[l - 1] = f"  apply {n}_thm" + '\n'
    lines[0] = f"import SSA.Projects.InstCombine.lean.{stem_name}_proof\n"
    # Write the modified content back to the file
    with open(file_path, 'w') as file:
        file.writelines(lines)

    # isempty =  os.stat(proof_name + ".lean").st_size
    # Append the messages to the end of the file
    with open(proof_name + ".lean", 'a') as file:
        file.write("""
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
""")
        for _, n, m in named:
            print(f"m = {m}")
            print(f"n = {n}")
            thm = m.replace("extracted_1", n + "_thm")
            print(thm)
            file.write(thm + '\n')
def main():
    # process_file("../lean-mlir/SSA/Projects/InstCombine/lean/xor.lean")
    directory = './SSA/Projects/InstCombine/lean'
    for root, _, files in os.walk(directory):
        for file in files:
            if file.endswith('.lean'):  # Assuming the files have a .lean extension
                file_path = os.path.join(root, file)
                print(file_path)
                process_file(file_path)

if __name__ == "__main__":
    main()
