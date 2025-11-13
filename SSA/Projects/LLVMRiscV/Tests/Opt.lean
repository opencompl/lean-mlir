import SSA.Projects.LLVMRiscV.ParseAndTransform

/--
error: Error parsing SSA/Projects/LLVMRiscV/Tests/Parsing/input.mlir:
Error:
Type mismatch: expected '"i1"', but 'name' has type '"i64"'
-/
#guard_msgs in
#eval! passriscv64 ("SSA/Projects/LLVMRiscV/Tests/Parsing/input.mlir")
