import SSA.Projects.InstCombine.tests.proofs.g2006h11h10hashrhmiscompile_proof
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
section g2006h11h10hashrhmiscompile_statements

def test_before := [llvm|
{
^0(%arg0 : i8):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.zext %arg0 : i8 to i32
  %2 = llvm.lshr %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test_after := [llvm|
{
^0(%arg0 : i8):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.zext nneg %arg0 : i8 to i32
  %2 = llvm.lshr %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
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


