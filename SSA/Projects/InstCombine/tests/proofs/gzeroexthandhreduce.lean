import SSA.Projects.InstCombine.tests.proofs.gzeroexthandhreduce_proof
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
section gzeroexthandhreduce_statements

def test1_before := [llvm|
{
^0(%arg0 : i8):
  %0 = llvm.mlir.constant(65544 : i32) : i32
  %1 = llvm.zext %arg0 : i8 to i32
  %2 = llvm.and %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg0 : i8):
  %0 = llvm.mlir.constant(8 : i8) : i8
  %1 = llvm.and %arg0, %0 : i8
  %2 = llvm.zext nneg %1 : i8 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test1_proof : test1_before ⊑ test1_after := by
  unfold test1_before test1_after
  simp_alive_peephole
  intros
  ---BEGIN test1
  apply test1_thm
  ---END test1


