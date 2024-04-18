#!/bin/bash
# Released under Apache 2.0 license as described in the file LICENSE.


#Using LLVM commit 55300991b5ed574812db318742fd0de3887b54dd
FOLDERS="InstCombine"

for f in $FOLDERS; do
  for file in $(ls $f/*.ll); do
    mlir-translate -mlir-print-op-generic --import-llvm "$file" -o "../InstCombine/$(basename "${file}" ".${s##*.}").mlir"
  done;
done;
