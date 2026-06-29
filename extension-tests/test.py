import os
import subprocess
from pathlib import Path
from collections import defaultdict

# zext

input_dir  = Path("zext")
output_dir = Path("zext_lowered")
input_dir.mkdir(exist_ok=True)
output_dir.mkdir(exist_ok=True)

errors = []

for from_width in range(1, 65):
    for to_width in range(1, 65):
        if from_width >= to_width:
            continue

        name = f"zext_i{from_width}_to_i{to_width}"
        in_path  = input_dir  / f"{name}.ll"
        out_path = output_dir / f"{name}.s"

        ll_content = f"""
define i{to_width} @main(i{from_width} %0) {{
  %2 = zext i{from_width} %0 to i{to_width}
  ret i{to_width} %2
}}
"""
        in_path.write_text(ll_content)

        result = subprocess.run(
            [
                "llc",
                "-march=riscv64",
                "-mcpu=generic-rv64",
                "-mattr=+m,+b,+zba,+zbb",
                "-filetype=asm",
                "-O0",
                str(in_path),
                "-o", str(out_path),
            ],
            capture_output=True,
            text=True,
        )

        if result.returncode != 0:
            errors.append((name, result.stderr.strip()))
            print(f"  FAIL  {name}: {result.stderr.strip()[:80]}")
        else:
            print(f"  OK    {name}")

print(f"\nDone. {len(errors)} error(s).")
if errors:
    print("\nFailed cases:")
    for name, err in errors:
        print(f"  {name}: {err}")

# sext

input_dir  = Path("sext")
output_dir = Path("sext_lowered")
input_dir.mkdir(exist_ok=True)
output_dir.mkdir(exist_ok=True)

errors = []

for from_width in range(1, 65):
    for to_width in range(1, 65):
        if from_width >= to_width:
            continue

        name = f"sext_i{from_width}_to_i{to_width}"
        in_path  = input_dir  / f"{name}.ll"
        out_path = output_dir / f"{name}.s"

        ll_content = f"""
define i{to_width} @main(i{from_width} %0) {{
  %2 = sext i{from_width} %0 to i{to_width}
  ret i{to_width} %2
}}
"""
        in_path.write_text(ll_content)

        result = subprocess.run(
            [
                "llc",
                "-march=riscv64",
                "-mcpu=generic-rv64",
                "-mattr=+m,+b,+zba,+zbb",
                "-filetype=asm",
                "-O0",
                str(in_path),
                "-o", str(out_path),
            ],
            capture_output=True,
            text=True,
        )

        if result.returncode != 0:
            errors.append((name, result.stderr.strip()))
            print(f"  FAIL  {name}: {result.stderr.strip()[:80]}")
        else:
            print(f"  OK    {name}")

print(f"\nDone. {len(errors)} error(s).")
if errors:
    print("\nFailed cases:")
    for name, err in errors:
        print(f"  {name}: {err}")
        
# trunc

input_dir  = Path("trunc")
output_dir = Path("trunc_lowered")
input_dir.mkdir(exist_ok=True)
output_dir.mkdir(exist_ok=True)

FLAGS = [
    "",           
    "nuw",
    "nsw",
    "nuw nsw",
]

errors = []

for from_width in range(1, 65):
    for to_width in range(1, 65):
        for flags in FLAGS:
            flag_str   = flags.replace(" ", "_") if flags else "none"
            name       = f"trunc_i{from_width}_to_i{to_width}_flags_{flag_str}"
            in_path    = input_dir  / f"{name}.ll"
            out_path   = output_dir / f"{name}.s"

            instr = f"trunc {flags + ' ' if flags else ''}i{from_width} %0 to i{to_width}"

            ll_content = f"""
define i{to_width} @main(i{from_width} %0) {{
  %2 = {instr}
  ret i{to_width} %2
}}
"""
            in_path.write_text(ll_content)

            result = subprocess.run(
                [
                    "llc",
                    "-march=riscv64",
                    "-mcpu=generic-rv64",
                    "-mattr=+m,+b,+zba,+zbb",
                    "-filetype=asm",
                    "-O0",
                    str(in_path),
                    "-o", str(out_path),
                ],
                capture_output=True,
                text=True,
            )

            if result.returncode != 0:
                errors.append((name, result.stderr.strip()))
                print(f"  FAIL  {name}: {result.stderr.strip()[:80]}")
            else:
                print(f"  OK    {name}")

print(f"\nDone. {len(errors)} error(s).")
if errors:
    print("\nFailed cases:")
    for name, err in errors:
        print(f"  {name}: {err}")

