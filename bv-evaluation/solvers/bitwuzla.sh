#!/bin/bash
set -e

input_file="$1"

# Measure time
start_time=$(date +%s%N) # Start time in nanoseconds
"$PWD/solvers/bitwuzla/build/src/main/bitwuzla" "$input_file"
end_time=$(date +%s%N)   # End time in nanoseconds

# Calculate and print the elapsed time
time=$((end_time - start_time))
echo "[time] total: $time"
