import SSA.Projects.InstCombine.tests.proofs.g2011h03h08hSRemMinusOneBadOpt_proof
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
section g2011h03h08hSRemMinusOneBadOpt_statements

def test_before := [llvm|
{
^0(%arg0 : i64):
  %0 = llvm.mlir.constant(4294967294) : i64
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.or %arg0, %0 : i64
  %3 = llvm.trunc %2 : i64 to i32
  %4 = llvm.srem %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test_after := [llvm|
{
^0(%arg0 : i64):
  %0 = llvm.mlir.constant(0 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
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


