import SSA.Projects.InstCombine.tests.proofs.g2008h10h11hDivCompareFold_proof
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
section g2008h10h11hDivCompareFold_statements

def x_before := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(65536 : i32) : i32
  %1 = llvm.mlir.constant(-65536 : i32) : i32
  %2 = llvm.sdiv %arg0, %0 : i32
  %3 = llvm.icmp "slt" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def x_after := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem x_proof : x_before ⊑ x_after := by
  unfold x_before x_after
  simp_alive_peephole
  intros
  ---BEGIN x
  apply x_thm
  ---END x


