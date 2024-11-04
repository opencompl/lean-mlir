import SSA.Projects.InstCombine.tests.proofs.g2007h03h21hSignedRangeTest_proof
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
section g2007h03h21hSignedRangeTest_statements

def test_before := [llvm|
{
^0(%arg1 : i32):
  %0 = llvm.mlir.constant(12 : i32) : i32
  %1 = llvm.mlir.constant(-6 : i32) : i32
  %2 = llvm.sdiv %arg1, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def test_after := [llvm|
{
^0(%arg1 : i32):
  %0 = llvm.mlir.constant(71 : i32) : i32
  %1 = llvm.mlir.constant(-12 : i32) : i32
  %2 = llvm.add %arg1, %0 : i32
  %3 = llvm.icmp "ult" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
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


