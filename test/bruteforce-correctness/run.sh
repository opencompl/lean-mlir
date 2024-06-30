#!/usr/bin/env bash
# Released under Apache 2.0 license as described in the file LICENSE.

set -e
set -o xtrace
rm -f generated* 
./llvm.py
(cd ../../ && (rm generated* || true) && lake build ssaLLVMEnumerator)
../../.lake/build/bin/ssaLLVMEnumerator
diff generated-llvm-optimized-data.csv generated-ssa-llvm-semantics.csv
diff <(awk -F, '$2 == 4' generated-ssa-llvm-semantics.csv | sort -t, -k1,1) <(awk -F, '$2 == 4' generated-ssa-llvm-syntax-and-semantics.csv | sort -t, -k1,1)
