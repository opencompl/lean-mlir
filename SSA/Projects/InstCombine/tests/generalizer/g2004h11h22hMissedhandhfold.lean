import SSA.Projects.InstCombine.tests.proofs.g2004h11h22hMissedhandhfold_proof
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
section g2004h11h22hMissedhandhfold_statements

def test21_before := [llvm|
{
^0(%arg0 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.ashr %arg0, %0 : i8
  %3 = llvm.and %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def test21_after := [llvm|
{
^0(%arg0 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.lshr %arg0, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test21_proof : test21_before ⊑ test21_after := by
  unfold test21_before test21_after
  simp_alive_peephole
  intros
  ---BEGIN test21
  apply test21_thm
  ---END test21


