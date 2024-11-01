
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open LLVM
open BitVec

open MLIR AST
open Ctxt (Var)

set_option linter.deprecated false
set_option linter.unreachableTactic false
set_option linter.unusedTactic false
section g2008h11h01hSRemDemandedBits_statements

def foo_before := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.srem %arg0, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def foo_after := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem foo_proof : foo_before ⊑ foo_after := by
  unfold foo_before foo_after
  simp_alive_peephole
  intros
  ---BEGIN foo
  all_goals (try extract_goal ; sorry)
  ---END foo


