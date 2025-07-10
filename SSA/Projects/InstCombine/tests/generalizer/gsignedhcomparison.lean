import SSA.Projects.InstCombine.tests.proofs.gsignedhcomparison_proof
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
section gsignedhcomparison_statements

def scalar_zext_slt_before := [llvm|
{
^0(%arg1 : i16):
  %0 = llvm.mlir.constant(500 : i32) : i32
  %1 = llvm.zext %arg1 : i16 to i32
  %2 = llvm.icmp "slt" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def scalar_zext_slt_after := [llvm|
{
^0(%arg1 : i16):
  %0 = llvm.mlir.constant(500 : i16) : i16
  %1 = llvm.icmp "ult" %arg1, %0 : i16
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem scalar_zext_slt_proof : scalar_zext_slt_before ⊑ scalar_zext_slt_after := by
  unfold scalar_zext_slt_before scalar_zext_slt_after
  simp_alive_peephole
  intros
  ---BEGIN scalar_zext_slt
  apply scalar_zext_slt_thm
  ---END scalar_zext_slt


