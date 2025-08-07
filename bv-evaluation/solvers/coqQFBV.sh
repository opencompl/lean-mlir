#!/bin/bash
set -e

input_file="$1"

export PATH="$PWD/solvers/coq-qfbv/bin:$PATH"
export OCAMLRUNPARAM="s=2G"

# Measure time
start_time=$(date +%s%N) # Start time in nanoseconds
"$PWD/solvers/coq-qfbv/bin/coqQFBV.exe" "$input_file"
end_time=$(date +%s%N)   # End time in nanoseconds

# Calculate and print the elapsed time
time=$((end_time - start_time))
echo "[time] total: $time"
