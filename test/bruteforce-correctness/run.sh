#!/usr/bin/env bash
set -e
set -o xtrace
rm generated* || true # don't error if no files are removed
./llvm.py
(cd ../../ && (rm generated* || true) && lake build ssaLLVMEnumerator)
../../.lake/build/bin/ssaLLVMEnumerator
diff generated-llvm-optimized-data.csv generated-ssa-llvm-semantics.csv
diff <(awk -F, '$2 == 4' generated-ssa-llvm-semantics.csv | sort -t, -k1,1) <(awk -F, '$2 == 4' generated-ssa-llvm-syntax-and-semantics.csv | sort -t, -k1,1)
