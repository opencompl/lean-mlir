
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
section gpreservedhanalyses_statements

def test_before := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(5 : i32) : i32
  %1 = llvm.mlir.constant(-5 : i32) : i32
  %2 = llvm.add %arg0, %0 : i32
  %3 = llvm.add %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test_after := [llvm|
{
^0(%arg0 : i32):
  "llvm.return"(%arg0) : (i32) -> ()
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


