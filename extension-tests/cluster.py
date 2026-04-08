import os
import subprocess
from pathlib import Path
from collections import defaultdict

# zext 

input_dir  = Path("zext")
output_dir = Path("zext_lowered")
input_dir.mkdir(exist_ok=True)
output_dir.mkdir(exist_ok=True)

def extract_instructions(asm_path):
    instructions = []
    for line in asm_path.read_text().splitlines():
        stripped = line.strip()
        # skip empty lines, comments, directives, labels
        if not stripped:
            continue
        if stripped.startswith("#"):
            continue
        if stripped.startswith("."):
            continue
        if stripped.endswith(":"):
            continue
        # kill: comments mid-line (e.g. "# kill: def $x10...")
        stripped = stripped.split("#")[0].strip()
        if not stripped:
            continue
        instructions.append(stripped)
    return tuple(instructions)

errors = []

clusters = defaultdict(list)

for asm_file in sorted(output_dir.glob("*.s")):
    instrs = extract_instructions(asm_file)
    clusters[instrs].append(asm_file.stem)

output_log_file = open("zext_clusters.txt", "w")

output_log_file.write(f"Found {len(clusters)} distinct instruction pattern(s)\n")
output_log_file.write("=" * 60)

for instrs, files in sorted(clusters.items(), key=lambda x: len(x[1]), reverse=True):
    output_log_file.write(f"\n[{len(files)} file(s)] Pattern:")
    if instrs:
        for instr in instrs:
            output_log_file.write(f"    {instr}")
    else:
        output_log_file.write("    (no instructions / empty body)")
    output_log_file.write(f"  Files: {', '.join(files)}")
    
# sext 

input_dir  = Path("sext")
output_dir = Path("sext_lowered")
input_dir.mkdir(exist_ok=True)
output_dir.mkdir(exist_ok=True)

def extract_instructions(asm_path):
    instructions = []
    for line in asm_path.read_text().splitlines():
        stripped = line.strip()
        # skip empty lines, comments, directives, labels
        if not stripped:
            continue
        if stripped.startswith("#"):
            continue
        if stripped.startswith("."):
            continue
        if stripped.endswith(":"):
            continue
        # kill: comments mid-line (e.g. "# kill: def $x10...")
        stripped = stripped.split("#")[0].strip()
        if not stripped:
            continue
        instructions.append(stripped)
    return tuple(instructions)

errors = []

clusters = defaultdict(list)

for asm_file in sorted(output_dir.glob("*.s")):
    instrs = extract_instructions(asm_file)
    clusters[instrs].append(asm_file.stem)

output_log_file = open("sext_clusters.txt", "w")

output_log_file.write(f"Found {len(clusters)} distinct instruction pattern(s)\n")
output_log_file.write("=" * 60)

for instrs, files in sorted(clusters.items(), key=lambda x: len(x[1]), reverse=True):
    output_log_file.write(f"\n[{len(files)} file(s)] Pattern:")
    if instrs:
        for instr in instrs:
            output_log_file.write(f"    {instr}")
    else:
        output_log_file.write("    (no instructions / empty body)")
    output_log_file.write(f"  Files: {', '.join(files)}")
    

# trunc

def extract_instructions(asm_path):
    instructions = []
    for line in asm_path.read_text().splitlines():
        stripped = line.strip()
        if not stripped or stripped.startswith("#") or stripped.startswith(".") or stripped.endswith(":"):
            continue
        stripped = stripped.split("#")[0].strip()
        if stripped:
            instructions.append(stripped)
    return tuple(instructions)

clusters = defaultdict(list)
for asm_file in sorted(output_dir.glob("*.s")):
    clusters[extract_instructions(asm_file)].append(asm_file.stem)

output_log_file = open("trunc_clusters.txt", "w")

output_log_file.write(f"\nFound {len(clusters)} distinct instruction pattern(s)\n")
output_log_file.write("=" * 60)
for instrs, files in sorted(clusters.items(), key=lambda x: len(x[1]), reverse=True):
    output_log_file.write(f"\n[{len(files)} file(s)] Pattern:")
    for instr in instrs or ["(empty)"]:
        output_log_file.write(f"    {instr}")
    # group files by flag variant for readability
    by_flag = defaultdict(list)
    for f in files:
        flag = f.split("_flags_")[-1]
        by_flag[flag].append(f)
    for flag, flist in sorted(by_flag.items()):
        output_log_file.write(f"  [{flag}] {len(flist)} case(s): {', '.join(flist[:5])}{'...' if len(flist) > 5 else ''}")