# The path from lean-mlir to llvm-project
llvm_path="../llvm-project"

if len(llvm_path) == 0:
    raise ValueError("You need to give the path to llvm in config.py")

test_path="/home/lfrenot/PLR/Stage/lean-mlir/SSA/Projects/InstCombine/tests/LLVM"