#!/usr/bin/env bash
#This script 
# Usage: ./process.sh <input_file>
cd $(dirname "$0")
INPUT_FILE="$1"

if [[ -z "$INPUT_FILE" ]]; then
  echo "Usage: $0 <input_file>"
  exit 1
fi

BASENAME=$(basename "$INPUT_FILE" .mlir)
OUT_MLIR="${BASENAME}_out.mlir"
OUT1_MLIR="${BASENAME}_out1.mlir"
# Translate LLVM IR to MLIR, optimize, and extract bb0
mlir-translate -import-llvm "$INPUT_FILE" | \
mlir-opt --mlir-print-op-generic | \
./extractbb0.sh > ${OUT_MLIR}

# Navigate up to the appropriate directory and run opt tool
cd ../../../../../ && \
lake exe opt --passriscv64 SSA/Projects/LLVMRiscV/tests/LLVMIR/${OUT_MLIR} > SSA/Projects/LLVMRiscV/tests/LLVMIR/${OUT1_MLIR}
