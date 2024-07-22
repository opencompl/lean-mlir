#!/usr/bin/env sh

# Create necessary directories
# mkdir -p combined combined-mlir before-mlir
mkdir -p vcombined vcombined-mlir vbefore-mlir

# Loop through each .ll file in the specified directory
for file in llvm-project-main/llvm/test/Transforms/InstCombine/*.ll; do
    # Extract the filename without path
    filename=$(basename "$file")
    d="${filename%.ll}"

    # Extract the RUN command
    run_cmd=$(grep '^; RUN:' "$file" | head -n 1 | sed 's/^; RUN: //' | sed 's/ |.*$//')
    echo $run_cmd

    # If the command doesn't end with -S, add it
    if [[ ! $run_cmd =~ -S$ ]]; then
        run_cmd="$run_cmd -S"
    fi
    run_cmd="${run_cmd/-disable-output/}"

    # Replace %s with the actual filename
    run_cmd="${run_cmd//%s/$file}"
    echo $run_cmd
    # Run the extracted command and save the output
    eval "$run_cmd" > "vcombined/${d}.ll"

    # Convert the processed LLVM to MLIR
    mlir-translate -import-llvm "vcombined/${d}.ll" | mlir-opt --mlir-print-op-generic > "vcombined-mlir/${d}.ll.mlir"

    # Convert the original LLVM to MLIR
    mlir-translate -import-llvm "$file" | mlir-opt --mlir-print-op-generic  > "vbefore-mlir/${d}.ll.mlir"
done
