
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
section gudiv_select_to_select_shift_statements

def test_before := [llvm|
{
^0(%arg2 : i64, %arg3 : i1):
  %0 = llvm.mlir.constant(16) : i64
  %1 = llvm.mlir.constant(8) : i64
  %2 = llvm.mlir.constant(0) : i64
  %3 = "llvm.select"(%arg3, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  %4 = llvm.udiv %arg2, %3 : i64
  %5 = "llvm.select"(%arg3, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  %6 = llvm.udiv %arg2, %5 : i64
  %7 = llvm.add %4, %6 : i64
  "llvm.return"(%7) : (i64) -> ()
}
]
def test_after := [llvm|
{
^0(%arg2 : i64, %arg3 : i1):
  %0 = llvm.mlir.constant(4) : i64
  %1 = llvm.mlir.constant(3) : i64
  %2 = llvm.lshr %arg2, %0 : i64
  %3 = llvm.lshr %arg2, %1 : i64
  %4 = llvm.add %2, %3 overflow<nsw,nuw> : i64
  "llvm.return"(%4) : (i64) -> ()
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


