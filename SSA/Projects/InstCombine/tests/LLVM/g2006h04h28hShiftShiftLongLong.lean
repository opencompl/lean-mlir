
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
section g2006h04h28hShiftShiftLongLong_statements

def test_before := [llvm|
{
^0(%arg0 : i64):
  %0 = llvm.mlir.constant(16) : i64
  %1 = llvm.shl %arg0, %0 : i64
  %2 = llvm.ashr %1, %0 : i64
  "llvm.return"(%2) : (i64) -> ()
}
]
def test_after := [llvm|
{
^0(%arg0 : i64):
  %0 = llvm.mlir.constant(16) : i64
  %1 = llvm.shl %arg0, %0 : i64
  %2 = llvm.ashr exact %1, %0 : i64
  "llvm.return"(%2) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_proof : test_before ⊑ test_after := by
  unfold test_before test_after
  simp_alive_peephole
  intros
  ---BEGIN test
  all_goals (try extract_goal ; sorry)
  ---END test


