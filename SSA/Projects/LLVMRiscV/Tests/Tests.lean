import SSA.Projects.LLVMRiscV.ParseAndTransform
import SSA.Projects.RISCV64.ParseAndTransform
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open LLVM
open BitVec

/--info: builtin.module {
^bb0(%0 : i64, %1 : i64, %2 : i1):
  "llvm.return"(%0) : (i64) -> ()
}
---
info: 0 -/
#guard_msgs in
#eval! passriscv64 "SSA/Projects/LLVMRiscV/Tests/example.mlir"
