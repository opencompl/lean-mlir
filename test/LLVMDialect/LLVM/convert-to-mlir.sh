#!/bin/bash

FOLDERS="InstCombine"

for f in $FOLDERS; do
  for file in $(ls $f/*.ll); do
    mlir-translate --import-llvm "$file" -o "../InstCombine/$(basename "${file}" ".${s##*.}").mlir"
  done;
done;
