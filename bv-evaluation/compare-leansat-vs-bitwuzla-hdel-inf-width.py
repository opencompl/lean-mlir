#!/usr/bin/env python3
import subprocess
import os 
import shutil 

root = subprocess.run(["git", "rev-parse", "--show-toplevel"], capture_output=True, text=True).stdout.strip() + "/"
print(f"root: {root}")
out_dir = root + "bv-evaluation/results/HackersDelight/Symbolic/"
print(f"Writing results to: {out_dir}")

# directory with benchmarks
in_dir = root + "SSA/Projects/InstCombine/HackersDelight/"
reps = 1

print(f"Removing existing results at {out_dir}.")

shutil.rmtree(out_dir, ignore_errors=True) # remove the existing results
os.makedirs(out_dir, exist_ok=True) # make directory.

bench_files = os.listdir(in_dir)
for (i, file) in enumerate(bench_files):
    print(f"processing file {file} {i+1}/{len(bench_files)}")
    subprocess.Popen(f"sed -i -E 's@BitVec .+@BitVec w@g' {in_dir}{file}", shell=True).wait()
    subprocess.Popen(f"sed -i -E 's@all_goals sorry@bv_auto@g' {in_dir}{file}", shell=True).wait()
    for r in range(reps):
        out_file = f"{os.path.basename(file)}_symbolic_r{r}.txt"
        print(f"  + writing output to: {out_dir}{out_file}")
        subprocess.Popen(f"cd {root} && lake lean {in_dir}{file} 2>&1 > {out_dir}{out_file}", shell=True).wait()
    subprocess.Popen(f"sed -i -E 's@bv_auto@all_goals sorry@g' {in_dir}{file}", shell=True).wait()
