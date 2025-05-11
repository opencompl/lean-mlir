
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
section gsremhcanonicalize_statements

def test_srem_canonicalize_op0_before := [llvm|
{
^0(%arg8 : i32, %arg9 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.sub %0, %arg8 overflow<nsw> : i32
  %2 = llvm.srem %1, %arg9 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test_srem_canonicalize_op0_after := [llvm|
{
^0(%arg8 : i32, %arg9 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.srem %arg8, %arg9 : i32
  %2 = llvm.sub %0, %1 overflow<nsw> : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_srem_canonicalize_op0_proof : test_srem_canonicalize_op0_before ⊑ test_srem_canonicalize_op0_after := by
  unfold test_srem_canonicalize_op0_before test_srem_canonicalize_op0_after
  simp_alive_peephole
  intros
  ---BEGIN test_srem_canonicalize_op0
  all_goals (try extract_goal ; sorry)
  ---END test_srem_canonicalize_op0


