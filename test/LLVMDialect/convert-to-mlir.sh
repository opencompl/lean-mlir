#!/bin/bash
# Released under Apache 2.0 license as described in the file LICENSE.


#!/bin/bash
FOLDERS="InstCombine"

for f in $FOLDERS; do
  for file in "$f"/*.ll; do
    base=$(basename "$file" .ll)
    mlir-translate -mlir-print-op-generic --import-llvm "$file" -o "$f/$base.mlir"
  done
done
