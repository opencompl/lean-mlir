import SSA.Projects.InstCombine.tests.proofs.g2007h03h19hBadTruncChangePR1261_proof
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
section g2007h03h19hBadTruncChangePR1261_statements

def test_before := [llvm|
{
^0(%arg0 : i31):
  %0 = llvm.mlir.constant(16384 : i32) : i32
  %1 = llvm.mlir.constant(15 : i32) : i32
  %2 = llvm.sext %arg0 : i31 to i32
  %3 = llvm.add %2, %0 : i32
  %4 = llvm.lshr %3, %1 : i32
  %5 = llvm.trunc %4 : i32 to i16
  "llvm.return"(%5) : (i16) -> ()
}
]
def test_after := [llvm|
{
^0(%arg0 : i31):
  %0 = llvm.mlir.constant(16384 : i32) : i32
  %1 = llvm.mlir.constant(15 : i32) : i32
  %2 = llvm.zext %arg0 : i31 to i32
  %3 = llvm.add %2, %0 overflow<nuw> : i32
  %4 = llvm.lshr %3, %1 : i32
  %5 = llvm.trunc %4 : i32 to i16
  "llvm.return"(%5) : (i16) -> ()
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


