import SSA.Projects.InstCombine.tests.proofs.g2004h08h10hBoolSetCC_proof
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
section g2004h08h10hBoolSetCC_statements

def test_before := [llvm|
{
^0(%arg0 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.icmp "ult" %arg0, %0 : i1
  "llvm.return"(%1) : (i1) -> ()
}
]
def test_after := [llvm|
{
^0(%arg0 : i1):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_proof : test_before ⊑ test_after := by
  unfold test_before test_after
  simp_alive_peephole
  intros
  ---BEGIN test
  apply test_thm
  ---END test


