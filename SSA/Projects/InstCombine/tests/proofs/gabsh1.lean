import SSA.Projects.InstCombine.tests.proofs.gabsh1_proof
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
section gabsh1_statements

def abs_must_be_positive_before := [llvm|
{
^0(%arg48 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.sub %0, %arg48 overflow<nsw> : i32
  %2 = llvm.icmp "sge" %arg48, %0 : i32
  %3 = "llvm.select"(%2, %arg48, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.icmp "sge" %3, %0 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def abs_must_be_positive_after := [llvm|
{
^0(%arg48 : i32):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem abs_must_be_positive_proof : abs_must_be_positive_before ⊑ abs_must_be_positive_after := by
  unfold abs_must_be_positive_before abs_must_be_positive_after
  simp_alive_peephole
  intros
  ---BEGIN abs_must_be_positive
  apply abs_must_be_positive_thm
  ---END abs_must_be_positive



def abs_diff_signed_slt_swap_wrong_pred1_before := [llvm|
{
^0(%arg15 : i32, %arg16 : i32):
  %0 = llvm.icmp "eq" %arg15, %arg16 : i32
  %1 = llvm.sub %arg16, %arg15 overflow<nsw> : i32
  %2 = llvm.sub %arg15, %arg16 overflow<nsw> : i32
  %3 = "llvm.select"(%0, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def abs_diff_signed_slt_swap_wrong_pred1_after := [llvm|
{
^0(%arg15 : i32, %arg16 : i32):
  %0 = llvm.sub %arg15, %arg16 overflow<nsw> : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem abs_diff_signed_slt_swap_wrong_pred1_proof : abs_diff_signed_slt_swap_wrong_pred1_before ⊑ abs_diff_signed_slt_swap_wrong_pred1_after := by
  unfold abs_diff_signed_slt_swap_wrong_pred1_before abs_diff_signed_slt_swap_wrong_pred1_after
  simp_alive_peephole
  intros
  ---BEGIN abs_diff_signed_slt_swap_wrong_pred1
  apply abs_diff_signed_slt_swap_wrong_pred1_thm
  ---END abs_diff_signed_slt_swap_wrong_pred1


