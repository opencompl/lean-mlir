#!/bin/bash

# Usage: ./process.sh <input_file>

INPUT_FILE="$1"

if [[ -z "$INPUT_FILE" ]]; then
  echo "Usage: $0 <input_file>"
  exit 1
fi

# Translate LLVM IR to MLIR, optimize, and extract bb0
mlir-translate -import-llvm "$INPUT_FILE" | \
mlir-opt --mlir-print-op-generic | \
./extractbb0.sh > out.mlir

# Navigate up to the appropriate directory and run opt tool
cd ../../../../../ && \
lake exe opt SSA/Projects/LLVMRiscV/tests/LLVMIR/out.mlir
