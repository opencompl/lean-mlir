These scripts are used to generate .lean files for bitblasting proofs.

mlir-tool.py generates .lean files based on LLVM's test cases.

types.py generates _proof.lean files from mlir-tool's output. These files contain theorems that should be solvable by bitblasting.

To use:

- Download and build llvm (with the mlir option) from [github](https://github.com/llvm/llvm-project)
- Add llvm's built binaires to your path
- Insert the path from lean-mlir to llvm-project in config.py
- run run.sh from this directory