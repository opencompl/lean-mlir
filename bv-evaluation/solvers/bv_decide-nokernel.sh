#!/bin/bash
set -e

input_file="$1"

export PATH="$HOME/.elan/toolchains/leanprover--lean4-nightly---nightly-2025-06-20/bin:$PATH"
export LEAN_PATH="$PWD/solvers/Leanwuzla/.lake/build/lib/lean:$HOME/.elan/toolchains/leanprover--lean4-nightly---nightly-2025-06-20/lib/lean"

ulimit -s unlimited

# Measure time
start_time=$(date +%s%N) # Start time in nanoseconds
"$PWD/solvers/Leanwuzla/.lake/build/bin/leanwuzla" --disableKernel --disableEmbeddedConstraintSubst --expthreshold=32768 --acnf --timeout=1200 --maxSteps=100000000 --maxHeartbeats=200000000 --maxRecDepth=1048576 "$input_file"
end_time=$(date +%s%N)   # End time in nanoseconds

# Calculate and print the elapsed time
time=$((end_time - start_time))
echo "[time] total: $time"
