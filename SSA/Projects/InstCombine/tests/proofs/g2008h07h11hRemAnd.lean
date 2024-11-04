import SSA.Projects.InstCombine.tests.proofs.g2008h07h11hRemAnd_proof
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
section g2008h07h11hRemAnd_statements

def a_before := [llvm|
{
^0(%arg1 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.srem %arg1, %0 : i32
  %3 = llvm.and %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def a_after := [llvm|
{
^0(%arg1 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.and %arg1, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem a_proof : a_before ⊑ a_after := by
  unfold a_before a_after
  simp_alive_peephole
  intros
  ---BEGIN a
  apply a_thm
  ---END a


