llvm_path=""

if len(llvm_path) == 0:
    raise ValueError("You need to give the path to llvm in config.py")

test_path="SSA/Projects/InstCombine/tests/LLVM"