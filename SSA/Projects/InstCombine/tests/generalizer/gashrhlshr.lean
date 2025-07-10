import SSA.Projects.InstCombine.tests.proofs.gashrhlshr_proof
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
section gashrhlshr_statements

def ashr_lshr_exact_ashr_only_before := [llvm|
{
^0(%arg133 : i32, %arg134 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.icmp "sgt" %arg133, %0 : i32
  %2 = llvm.lshr %arg133, %arg134 : i32
  %3 = llvm.ashr exact %arg133, %arg134 : i32
  %4 = "llvm.select"(%1, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def ashr_lshr_exact_ashr_only_after := [llvm|
{
^0(%arg133 : i32, %arg134 : i32):
  %0 = llvm.ashr %arg133, %arg134 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_lshr_exact_ashr_only_proof : ashr_lshr_exact_ashr_only_before ⊑ ashr_lshr_exact_ashr_only_after := by
  unfold ashr_lshr_exact_ashr_only_before ashr_lshr_exact_ashr_only_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_lshr_exact_ashr_only
  apply ashr_lshr_exact_ashr_only_thm
  ---END ashr_lshr_exact_ashr_only



def ashr_lshr_no_exact_before := [llvm|
{
^0(%arg131 : i32, %arg132 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.icmp "sgt" %arg131, %0 : i32
  %2 = llvm.lshr %arg131, %arg132 : i32
  %3 = llvm.ashr %arg131, %arg132 : i32
  %4 = "llvm.select"(%1, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def ashr_lshr_no_exact_after := [llvm|
{
^0(%arg131 : i32, %arg132 : i32):
  %0 = llvm.ashr %arg131, %arg132 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_lshr_no_exact_proof : ashr_lshr_no_exact_before ⊑ ashr_lshr_no_exact_after := by
  unfold ashr_lshr_no_exact_before ashr_lshr_no_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_lshr_no_exact
  apply ashr_lshr_no_exact_thm
  ---END ashr_lshr_no_exact



def ashr_lshr_exact_both_before := [llvm|
{
^0(%arg129 : i32, %arg130 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.icmp "sgt" %arg129, %0 : i32
  %2 = llvm.lshr exact %arg129, %arg130 : i32
  %3 = llvm.ashr exact %arg129, %arg130 : i32
  %4 = "llvm.select"(%1, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def ashr_lshr_exact_both_after := [llvm|
{
^0(%arg129 : i32, %arg130 : i32):
  %0 = llvm.ashr exact %arg129, %arg130 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_lshr_exact_both_proof : ashr_lshr_exact_both_before ⊑ ashr_lshr_exact_both_after := by
  unfold ashr_lshr_exact_both_before ashr_lshr_exact_both_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_lshr_exact_both
  apply ashr_lshr_exact_both_thm
  ---END ashr_lshr_exact_both



def ashr_lshr_exact_lshr_only_before := [llvm|
{
^0(%arg127 : i32, %arg128 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.icmp "sgt" %arg127, %0 : i32
  %2 = llvm.lshr exact %arg127, %arg128 : i32
  %3 = llvm.ashr %arg127, %arg128 : i32
  %4 = "llvm.select"(%1, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def ashr_lshr_exact_lshr_only_after := [llvm|
{
^0(%arg127 : i32, %arg128 : i32):
  %0 = llvm.ashr %arg127, %arg128 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_lshr_exact_lshr_only_proof : ashr_lshr_exact_lshr_only_before ⊑ ashr_lshr_exact_lshr_only_after := by
  unfold ashr_lshr_exact_lshr_only_before ashr_lshr_exact_lshr_only_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_lshr_exact_lshr_only
  apply ashr_lshr_exact_lshr_only_thm
  ---END ashr_lshr_exact_lshr_only



def ashr_lshr2_before := [llvm|
{
^0(%arg125 : i32, %arg126 : i32):
  %0 = llvm.mlir.constant(5 : i32) : i32
  %1 = llvm.icmp "sgt" %arg125, %0 : i32
  %2 = llvm.lshr %arg125, %arg126 : i32
  %3 = llvm.ashr exact %arg125, %arg126 : i32
  %4 = "llvm.select"(%1, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def ashr_lshr2_after := [llvm|
{
^0(%arg125 : i32, %arg126 : i32):
  %0 = llvm.ashr %arg125, %arg126 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_lshr2_proof : ashr_lshr2_before ⊑ ashr_lshr2_after := by
  unfold ashr_lshr2_before ashr_lshr2_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_lshr2
  apply ashr_lshr2_thm
  ---END ashr_lshr2



def ashr_lshr2_i128_before := [llvm|
{
^0(%arg123 : i128, %arg124 : i128):
  %0 = llvm.mlir.constant(5 : i128) : i128
  %1 = llvm.icmp "sgt" %arg123, %0 : i128
  %2 = llvm.lshr %arg123, %arg124 : i128
  %3 = llvm.ashr exact %arg123, %arg124 : i128
  %4 = "llvm.select"(%1, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i128, i128) -> i128
  "llvm.return"(%4) : (i128) -> ()
}
]
def ashr_lshr2_i128_after := [llvm|
{
^0(%arg123 : i128, %arg124 : i128):
  %0 = llvm.ashr %arg123, %arg124 : i128
  "llvm.return"(%0) : (i128) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_lshr2_i128_proof : ashr_lshr2_i128_before ⊑ ashr_lshr2_i128_after := by
  unfold ashr_lshr2_i128_before ashr_lshr2_i128_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_lshr2_i128
  apply ashr_lshr2_i128_thm
  ---END ashr_lshr2_i128



def ashr_lshr_cst_before := [llvm|
{
^0(%arg105 : i32, %arg106 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.icmp "slt" %arg105, %0 : i32
  %3 = llvm.lshr %arg105, %1 : i32
  %4 = llvm.ashr exact %arg105, %1 : i32
  %5 = "llvm.select"(%2, %4, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def ashr_lshr_cst_after := [llvm|
{
^0(%arg105 : i32, %arg106 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.ashr %arg105, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_lshr_cst_proof : ashr_lshr_cst_before ⊑ ashr_lshr_cst_after := by
  unfold ashr_lshr_cst_before ashr_lshr_cst_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_lshr_cst
  apply ashr_lshr_cst_thm
  ---END ashr_lshr_cst



def ashr_lshr_cst2_before := [llvm|
{
^0(%arg103 : i32, %arg104 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.icmp "sgt" %arg103, %0 : i32
  %3 = llvm.lshr %arg103, %1 : i32
  %4 = llvm.ashr exact %arg103, %1 : i32
  %5 = "llvm.select"(%2, %3, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def ashr_lshr_cst2_after := [llvm|
{
^0(%arg103 : i32, %arg104 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.ashr %arg103, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_lshr_cst2_proof : ashr_lshr_cst2_before ⊑ ashr_lshr_cst2_after := by
  unfold ashr_lshr_cst2_before ashr_lshr_cst2_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_lshr_cst2
  apply ashr_lshr_cst2_thm
  ---END ashr_lshr_cst2



def ashr_lshr_inv_before := [llvm|
{
^0(%arg101 : i32, %arg102 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.icmp "slt" %arg101, %0 : i32
  %2 = llvm.lshr %arg101, %arg102 : i32
  %3 = llvm.ashr exact %arg101, %arg102 : i32
  %4 = "llvm.select"(%1, %3, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def ashr_lshr_inv_after := [llvm|
{
^0(%arg101 : i32, %arg102 : i32):
  %0 = llvm.ashr %arg101, %arg102 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_lshr_inv_proof : ashr_lshr_inv_before ⊑ ashr_lshr_inv_after := by
  unfold ashr_lshr_inv_before ashr_lshr_inv_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_lshr_inv
  apply ashr_lshr_inv_thm
  ---END ashr_lshr_inv



def ashr_lshr_inv2_before := [llvm|
{
^0(%arg99 : i32, %arg100 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.icmp "slt" %arg99, %0 : i32
  %2 = llvm.lshr %arg99, %arg100 : i32
  %3 = llvm.ashr exact %arg99, %arg100 : i32
  %4 = "llvm.select"(%1, %3, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def ashr_lshr_inv2_after := [llvm|
{
^0(%arg99 : i32, %arg100 : i32):
  %0 = llvm.ashr %arg99, %arg100 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_lshr_inv2_proof : ashr_lshr_inv2_before ⊑ ashr_lshr_inv2_after := by
  unfold ashr_lshr_inv2_before ashr_lshr_inv2_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_lshr_inv2
  apply ashr_lshr_inv2_thm
  ---END ashr_lshr_inv2



def ashr_lshr_wrong_cond_before := [llvm|
{
^0(%arg85 : i32, %arg86 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.icmp "sge" %arg85, %0 : i32
  %2 = llvm.lshr %arg85, %arg86 : i32
  %3 = llvm.ashr %arg85, %arg86 : i32
  %4 = "llvm.select"(%1, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def ashr_lshr_wrong_cond_after := [llvm|
{
^0(%arg85 : i32, %arg86 : i32):
  %0 = llvm.mlir.constant(-2 : i32) : i32
  %1 = llvm.icmp "sgt" %arg85, %0 : i32
  %2 = llvm.lshr %arg85, %arg86 : i32
  %3 = llvm.ashr %arg85, %arg86 : i32
  %4 = "llvm.select"(%1, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_lshr_wrong_cond_proof : ashr_lshr_wrong_cond_before ⊑ ashr_lshr_wrong_cond_after := by
  unfold ashr_lshr_wrong_cond_before ashr_lshr_wrong_cond_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_lshr_wrong_cond
  apply ashr_lshr_wrong_cond_thm
  ---END ashr_lshr_wrong_cond



def ashr_lshr_shift_wrong_pred_before := [llvm|
{
^0(%arg82 : i32, %arg83 : i32, %arg84 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "sle" %arg82, %0 : i32
  %2 = llvm.lshr %arg82, %arg83 : i32
  %3 = llvm.ashr %arg82, %arg83 : i32
  %4 = "llvm.select"(%1, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def ashr_lshr_shift_wrong_pred_after := [llvm|
{
^0(%arg82 : i32, %arg83 : i32, %arg84 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.icmp "slt" %arg82, %0 : i32
  %2 = llvm.lshr %arg82, %arg83 : i32
  %3 = llvm.ashr %arg82, %arg83 : i32
  %4 = "llvm.select"(%1, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_lshr_shift_wrong_pred_proof : ashr_lshr_shift_wrong_pred_before ⊑ ashr_lshr_shift_wrong_pred_after := by
  unfold ashr_lshr_shift_wrong_pred_before ashr_lshr_shift_wrong_pred_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_lshr_shift_wrong_pred
  apply ashr_lshr_shift_wrong_pred_thm
  ---END ashr_lshr_shift_wrong_pred



def ashr_lshr_shift_wrong_pred2_before := [llvm|
{
^0(%arg79 : i32, %arg80 : i32, %arg81 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "sge" %arg81, %0 : i32
  %2 = llvm.lshr %arg79, %arg80 : i32
  %3 = llvm.ashr %arg79, %arg80 : i32
  %4 = "llvm.select"(%1, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def ashr_lshr_shift_wrong_pred2_after := [llvm|
{
^0(%arg79 : i32, %arg80 : i32, %arg81 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.lshr %arg79, %arg80 : i32
  %2 = llvm.ashr %arg79, %arg80 : i32
  %3 = llvm.icmp "slt" %arg81, %0 : i32
  %4 = "llvm.select"(%3, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_lshr_shift_wrong_pred2_proof : ashr_lshr_shift_wrong_pred2_before ⊑ ashr_lshr_shift_wrong_pred2_after := by
  unfold ashr_lshr_shift_wrong_pred2_before ashr_lshr_shift_wrong_pred2_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_lshr_shift_wrong_pred2
  apply ashr_lshr_shift_wrong_pred2_thm
  ---END ashr_lshr_shift_wrong_pred2



def ashr_lshr_wrong_operands_before := [llvm|
{
^0(%arg77 : i32, %arg78 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "sge" %arg77, %0 : i32
  %2 = llvm.lshr %arg77, %arg78 : i32
  %3 = llvm.ashr %arg77, %arg78 : i32
  %4 = "llvm.select"(%1, %3, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def ashr_lshr_wrong_operands_after := [llvm|
{
^0(%arg77 : i32, %arg78 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.lshr %arg77, %arg78 : i32
  %2 = llvm.ashr %arg77, %arg78 : i32
  %3 = llvm.icmp "slt" %arg77, %0 : i32
  %4 = "llvm.select"(%3, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_lshr_wrong_operands_proof : ashr_lshr_wrong_operands_before ⊑ ashr_lshr_wrong_operands_after := by
  unfold ashr_lshr_wrong_operands_before ashr_lshr_wrong_operands_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_lshr_wrong_operands
  apply ashr_lshr_wrong_operands_thm
  ---END ashr_lshr_wrong_operands



def ashr_lshr_no_ashr_before := [llvm|
{
^0(%arg75 : i32, %arg76 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "sge" %arg75, %0 : i32
  %2 = llvm.lshr %arg75, %arg76 : i32
  %3 = llvm.xor %arg75, %arg76 : i32
  %4 = "llvm.select"(%1, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def ashr_lshr_no_ashr_after := [llvm|
{
^0(%arg75 : i32, %arg76 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.lshr %arg75, %arg76 : i32
  %2 = llvm.xor %arg75, %arg76 : i32
  %3 = llvm.icmp "slt" %arg75, %0 : i32
  %4 = "llvm.select"(%3, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_lshr_no_ashr_proof : ashr_lshr_no_ashr_before ⊑ ashr_lshr_no_ashr_after := by
  unfold ashr_lshr_no_ashr_before ashr_lshr_no_ashr_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_lshr_no_ashr
  apply ashr_lshr_no_ashr_thm
  ---END ashr_lshr_no_ashr



def ashr_lshr_shift_amt_mismatch_before := [llvm|
{
^0(%arg72 : i32, %arg73 : i32, %arg74 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "sge" %arg72, %0 : i32
  %2 = llvm.lshr %arg72, %arg73 : i32
  %3 = llvm.ashr %arg72, %arg74 : i32
  %4 = "llvm.select"(%1, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def ashr_lshr_shift_amt_mismatch_after := [llvm|
{
^0(%arg72 : i32, %arg73 : i32, %arg74 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.lshr %arg72, %arg73 : i32
  %2 = llvm.ashr %arg72, %arg74 : i32
  %3 = llvm.icmp "slt" %arg72, %0 : i32
  %4 = "llvm.select"(%3, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_lshr_shift_amt_mismatch_proof : ashr_lshr_shift_amt_mismatch_before ⊑ ashr_lshr_shift_amt_mismatch_after := by
  unfold ashr_lshr_shift_amt_mismatch_before ashr_lshr_shift_amt_mismatch_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_lshr_shift_amt_mismatch
  apply ashr_lshr_shift_amt_mismatch_thm
  ---END ashr_lshr_shift_amt_mismatch



def ashr_lshr_shift_base_mismatch_before := [llvm|
{
^0(%arg69 : i32, %arg70 : i32, %arg71 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "sge" %arg69, %0 : i32
  %2 = llvm.lshr %arg69, %arg70 : i32
  %3 = llvm.ashr %arg71, %arg70 : i32
  %4 = "llvm.select"(%1, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def ashr_lshr_shift_base_mismatch_after := [llvm|
{
^0(%arg69 : i32, %arg70 : i32, %arg71 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.lshr %arg69, %arg70 : i32
  %2 = llvm.ashr %arg71, %arg70 : i32
  %3 = llvm.icmp "slt" %arg69, %0 : i32
  %4 = "llvm.select"(%3, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_lshr_shift_base_mismatch_proof : ashr_lshr_shift_base_mismatch_before ⊑ ashr_lshr_shift_base_mismatch_after := by
  unfold ashr_lshr_shift_base_mismatch_before ashr_lshr_shift_base_mismatch_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_lshr_shift_base_mismatch
  apply ashr_lshr_shift_base_mismatch_thm
  ---END ashr_lshr_shift_base_mismatch



def ashr_lshr_no_lshr_before := [llvm|
{
^0(%arg67 : i32, %arg68 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "sge" %arg67, %0 : i32
  %2 = llvm.add %arg67, %arg68 : i32
  %3 = llvm.ashr %arg67, %arg68 : i32
  %4 = "llvm.select"(%1, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def ashr_lshr_no_lshr_after := [llvm|
{
^0(%arg67 : i32, %arg68 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.add %arg67, %arg68 : i32
  %2 = llvm.ashr %arg67, %arg68 : i32
  %3 = llvm.icmp "slt" %arg67, %0 : i32
  %4 = "llvm.select"(%3, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_lshr_no_lshr_proof : ashr_lshr_no_lshr_before ⊑ ashr_lshr_no_lshr_after := by
  unfold ashr_lshr_no_lshr_before ashr_lshr_no_lshr_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_lshr_no_lshr
  apply ashr_lshr_no_lshr_thm
  ---END ashr_lshr_no_lshr



def lshr_sub_nsw_before := [llvm|
{
^0(%arg61 : i32, %arg62 : i32):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.sub %arg61, %arg62 overflow<nsw> : i32
  %2 = llvm.lshr %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def lshr_sub_nsw_after := [llvm|
{
^0(%arg61 : i32, %arg62 : i32):
  %0 = llvm.icmp "slt" %arg61, %arg62 : i32
  %1 = llvm.zext %0 : i1 to i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_sub_nsw_proof : lshr_sub_nsw_before ⊑ lshr_sub_nsw_after := by
  unfold lshr_sub_nsw_before lshr_sub_nsw_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_sub_nsw
  apply lshr_sub_nsw_thm
  ---END lshr_sub_nsw



def ashr_sub_nsw_before := [llvm|
{
^0(%arg48 : i17, %arg49 : i17):
  %0 = llvm.mlir.constant(16 : i17) : i17
  %1 = llvm.sub %arg48, %arg49 overflow<nsw> : i17
  %2 = llvm.ashr %1, %0 : i17
  "llvm.return"(%2) : (i17) -> ()
}
]
def ashr_sub_nsw_after := [llvm|
{
^0(%arg48 : i17, %arg49 : i17):
  %0 = llvm.icmp "slt" %arg48, %arg49 : i17
  %1 = llvm.sext %0 : i1 to i17
  "llvm.return"(%1) : (i17) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_sub_nsw_proof : ashr_sub_nsw_before ⊑ ashr_sub_nsw_after := by
  unfold ashr_sub_nsw_before ashr_sub_nsw_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_sub_nsw
  apply ashr_sub_nsw_thm
  ---END ashr_sub_nsw



def ashr_known_pos_exact_before := [llvm|
{
^0(%arg35 : i8, %arg36 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.and %arg35, %0 : i8
  %2 = llvm.ashr exact %1, %arg36 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def ashr_known_pos_exact_after := [llvm|
{
^0(%arg35 : i8, %arg36 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.and %arg35, %0 : i8
  %2 = llvm.lshr exact %1, %arg36 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_known_pos_exact_proof : ashr_known_pos_exact_before ⊑ ashr_known_pos_exact_after := by
  unfold ashr_known_pos_exact_before ashr_known_pos_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_known_pos_exact
  apply ashr_known_pos_exact_thm
  ---END ashr_known_pos_exact



def lshr_mul_times_3_div_2_before := [llvm|
{
^0(%arg32 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.mul %arg32, %0 overflow<nsw,nuw> : i32
  %3 = llvm.lshr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def lshr_mul_times_3_div_2_after := [llvm|
{
^0(%arg32 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.lshr %arg32, %0 : i32
  %2 = llvm.add %arg32, %1 overflow<nsw,nuw> : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_mul_times_3_div_2_proof : lshr_mul_times_3_div_2_before ⊑ lshr_mul_times_3_div_2_after := by
  unfold lshr_mul_times_3_div_2_before lshr_mul_times_3_div_2_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_mul_times_3_div_2
  apply lshr_mul_times_3_div_2_thm
  ---END lshr_mul_times_3_div_2



def lshr_mul_times_3_div_2_exact_before := [llvm|
{
^0(%arg31 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.mul %arg31, %0 overflow<nsw> : i32
  %3 = llvm.lshr exact %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def lshr_mul_times_3_div_2_exact_after := [llvm|
{
^0(%arg31 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.lshr exact %arg31, %0 : i32
  %2 = llvm.add %arg31, %1 overflow<nsw> : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_mul_times_3_div_2_exact_proof : lshr_mul_times_3_div_2_exact_before ⊑ lshr_mul_times_3_div_2_exact_after := by
  unfold lshr_mul_times_3_div_2_exact_before lshr_mul_times_3_div_2_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_mul_times_3_div_2_exact
  apply lshr_mul_times_3_div_2_exact_thm
  ---END lshr_mul_times_3_div_2_exact



def lshr_mul_times_3_div_2_exact_2_before := [llvm|
{
^0(%arg28 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.mul %arg28, %0 overflow<nuw> : i32
  %3 = llvm.lshr exact %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def lshr_mul_times_3_div_2_exact_2_after := [llvm|
{
^0(%arg28 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.lshr exact %arg28, %0 : i32
  %2 = llvm.add %arg28, %1 overflow<nuw> : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_mul_times_3_div_2_exact_2_proof : lshr_mul_times_3_div_2_exact_2_before ⊑ lshr_mul_times_3_div_2_exact_2_after := by
  unfold lshr_mul_times_3_div_2_exact_2_before lshr_mul_times_3_div_2_exact_2_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_mul_times_3_div_2_exact_2
  apply lshr_mul_times_3_div_2_exact_2_thm
  ---END lshr_mul_times_3_div_2_exact_2



def lshr_mul_times_5_div_4_before := [llvm|
{
^0(%arg27 : i32):
  %0 = llvm.mlir.constant(5 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.mul %arg27, %0 overflow<nsw,nuw> : i32
  %3 = llvm.lshr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def lshr_mul_times_5_div_4_after := [llvm|
{
^0(%arg27 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.lshr %arg27, %0 : i32
  %2 = llvm.add %arg27, %1 overflow<nsw,nuw> : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_mul_times_5_div_4_proof : lshr_mul_times_5_div_4_before ⊑ lshr_mul_times_5_div_4_after := by
  unfold lshr_mul_times_5_div_4_before lshr_mul_times_5_div_4_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_mul_times_5_div_4
  apply lshr_mul_times_5_div_4_thm
  ---END lshr_mul_times_5_div_4



def lshr_mul_times_5_div_4_exact_before := [llvm|
{
^0(%arg26 : i32):
  %0 = llvm.mlir.constant(5 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.mul %arg26, %0 overflow<nsw> : i32
  %3 = llvm.lshr exact %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def lshr_mul_times_5_div_4_exact_after := [llvm|
{
^0(%arg26 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.lshr exact %arg26, %0 : i32
  %2 = llvm.add %arg26, %1 overflow<nsw> : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_mul_times_5_div_4_exact_proof : lshr_mul_times_5_div_4_exact_before ⊑ lshr_mul_times_5_div_4_exact_after := by
  unfold lshr_mul_times_5_div_4_exact_before lshr_mul_times_5_div_4_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_mul_times_5_div_4_exact
  apply lshr_mul_times_5_div_4_exact_thm
  ---END lshr_mul_times_5_div_4_exact



def lshr_mul_times_5_div_4_exact_2_before := [llvm|
{
^0(%arg23 : i32):
  %0 = llvm.mlir.constant(5 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.mul %arg23, %0 overflow<nuw> : i32
  %3 = llvm.lshr exact %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def lshr_mul_times_5_div_4_exact_2_after := [llvm|
{
^0(%arg23 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.lshr exact %arg23, %0 : i32
  %2 = llvm.add %arg23, %1 overflow<nuw> : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_mul_times_5_div_4_exact_2_proof : lshr_mul_times_5_div_4_exact_2_before ⊑ lshr_mul_times_5_div_4_exact_2_after := by
  unfold lshr_mul_times_5_div_4_exact_2_before lshr_mul_times_5_div_4_exact_2_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_mul_times_5_div_4_exact_2
  apply lshr_mul_times_5_div_4_exact_2_thm
  ---END lshr_mul_times_5_div_4_exact_2



def ashr_mul_times_3_div_2_before := [llvm|
{
^0(%arg22 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.mul %arg22, %0 overflow<nsw,nuw> : i32
  %3 = llvm.ashr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def ashr_mul_times_3_div_2_after := [llvm|
{
^0(%arg22 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.lshr %arg22, %0 : i32
  %2 = llvm.add %arg22, %1 overflow<nsw,nuw> : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_mul_times_3_div_2_proof : ashr_mul_times_3_div_2_before ⊑ ashr_mul_times_3_div_2_after := by
  unfold ashr_mul_times_3_div_2_before ashr_mul_times_3_div_2_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_mul_times_3_div_2
  apply ashr_mul_times_3_div_2_thm
  ---END ashr_mul_times_3_div_2



def ashr_mul_times_3_div_2_exact_before := [llvm|
{
^0(%arg21 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.mul %arg21, %0 overflow<nsw> : i32
  %3 = llvm.ashr exact %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def ashr_mul_times_3_div_2_exact_after := [llvm|
{
^0(%arg21 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.ashr exact %arg21, %0 : i32
  %2 = llvm.add %arg21, %1 overflow<nsw> : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_mul_times_3_div_2_exact_proof : ashr_mul_times_3_div_2_exact_before ⊑ ashr_mul_times_3_div_2_exact_after := by
  unfold ashr_mul_times_3_div_2_exact_before ashr_mul_times_3_div_2_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_mul_times_3_div_2_exact
  apply ashr_mul_times_3_div_2_exact_thm
  ---END ashr_mul_times_3_div_2_exact



def ashr_mul_times_3_div_2_exact_2_before := [llvm|
{
^0(%arg17 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.mul %arg17, %0 overflow<nsw> : i32
  %3 = llvm.ashr exact %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def ashr_mul_times_3_div_2_exact_2_after := [llvm|
{
^0(%arg17 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.ashr exact %arg17, %0 : i32
  %2 = llvm.add %arg17, %1 overflow<nsw> : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_mul_times_3_div_2_exact_2_proof : ashr_mul_times_3_div_2_exact_2_before ⊑ ashr_mul_times_3_div_2_exact_2_after := by
  unfold ashr_mul_times_3_div_2_exact_2_before ashr_mul_times_3_div_2_exact_2_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_mul_times_3_div_2_exact_2
  apply ashr_mul_times_3_div_2_exact_2_thm
  ---END ashr_mul_times_3_div_2_exact_2



def ashr_mul_times_5_div_4_before := [llvm|
{
^0(%arg16 : i32):
  %0 = llvm.mlir.constant(5 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.mul %arg16, %0 overflow<nsw,nuw> : i32
  %3 = llvm.ashr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def ashr_mul_times_5_div_4_after := [llvm|
{
^0(%arg16 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.lshr %arg16, %0 : i32
  %2 = llvm.add %arg16, %1 overflow<nsw,nuw> : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_mul_times_5_div_4_proof : ashr_mul_times_5_div_4_before ⊑ ashr_mul_times_5_div_4_after := by
  unfold ashr_mul_times_5_div_4_before ashr_mul_times_5_div_4_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_mul_times_5_div_4
  apply ashr_mul_times_5_div_4_thm
  ---END ashr_mul_times_5_div_4



def ashr_mul_times_5_div_4_exact_before := [llvm|
{
^0(%arg15 : i32):
  %0 = llvm.mlir.constant(5 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.mul %arg15, %0 overflow<nsw> : i32
  %3 = llvm.ashr exact %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def ashr_mul_times_5_div_4_exact_after := [llvm|
{
^0(%arg15 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.ashr exact %arg15, %0 : i32
  %2 = llvm.add %arg15, %1 overflow<nsw> : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_mul_times_5_div_4_exact_proof : ashr_mul_times_5_div_4_exact_before ⊑ ashr_mul_times_5_div_4_exact_after := by
  unfold ashr_mul_times_5_div_4_exact_before ashr_mul_times_5_div_4_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_mul_times_5_div_4_exact
  apply ashr_mul_times_5_div_4_exact_thm
  ---END ashr_mul_times_5_div_4_exact



def ashr_mul_times_5_div_4_exact_2_before := [llvm|
{
^0(%arg12 : i32):
  %0 = llvm.mlir.constant(5 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.mul %arg12, %0 overflow<nsw> : i32
  %3 = llvm.ashr exact %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def ashr_mul_times_5_div_4_exact_2_after := [llvm|
{
^0(%arg12 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.ashr exact %arg12, %0 : i32
  %2 = llvm.add %arg12, %1 overflow<nsw> : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_mul_times_5_div_4_exact_2_proof : ashr_mul_times_5_div_4_exact_2_before ⊑ ashr_mul_times_5_div_4_exact_2_after := by
  unfold ashr_mul_times_5_div_4_exact_2_before ashr_mul_times_5_div_4_exact_2_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_mul_times_5_div_4_exact_2
  apply ashr_mul_times_5_div_4_exact_2_thm
  ---END ashr_mul_times_5_div_4_exact_2



def lsb_mask_sign_zext_before := [llvm|
{
^0(%arg11 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(31 : i32) : i32
  %2 = llvm.add %arg11, %0 : i32
  %3 = llvm.xor %arg11, %0 : i32
  %4 = llvm.and %2, %3 : i32
  %5 = llvm.lshr %4, %1 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def lsb_mask_sign_zext_after := [llvm|
{
^0(%arg11 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "eq" %arg11, %0 : i32
  %2 = llvm.zext %1 : i1 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lsb_mask_sign_zext_proof : lsb_mask_sign_zext_before ⊑ lsb_mask_sign_zext_after := by
  unfold lsb_mask_sign_zext_before lsb_mask_sign_zext_after
  simp_alive_peephole
  intros
  ---BEGIN lsb_mask_sign_zext
  apply lsb_mask_sign_zext_thm
  ---END lsb_mask_sign_zext



def lsb_mask_sign_zext_commuted_before := [llvm|
{
^0(%arg10 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(31 : i32) : i32
  %2 = llvm.add %arg10, %0 : i32
  %3 = llvm.xor %arg10, %0 : i32
  %4 = llvm.and %3, %2 : i32
  %5 = llvm.lshr %4, %1 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def lsb_mask_sign_zext_commuted_after := [llvm|
{
^0(%arg10 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "eq" %arg10, %0 : i32
  %2 = llvm.zext %1 : i1 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lsb_mask_sign_zext_commuted_proof : lsb_mask_sign_zext_commuted_before ⊑ lsb_mask_sign_zext_commuted_after := by
  unfold lsb_mask_sign_zext_commuted_before lsb_mask_sign_zext_commuted_after
  simp_alive_peephole
  intros
  ---BEGIN lsb_mask_sign_zext_commuted
  apply lsb_mask_sign_zext_commuted_thm
  ---END lsb_mask_sign_zext_commuted



def lsb_mask_sign_zext_wrong_cst2_before := [llvm|
{
^0(%arg8 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.mlir.constant(31 : i32) : i32
  %3 = llvm.add %arg8, %0 : i32
  %4 = llvm.xor %arg8, %1 : i32
  %5 = llvm.and %3, %4 : i32
  %6 = llvm.lshr %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def lsb_mask_sign_zext_wrong_cst2_after := [llvm|
{
^0(%arg8 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(31 : i32) : i32
  %2 = llvm.add %arg8, %0 : i32
  %3 = llvm.and %2, %arg8 : i32
  %4 = llvm.lshr %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lsb_mask_sign_zext_wrong_cst2_proof : lsb_mask_sign_zext_wrong_cst2_before ⊑ lsb_mask_sign_zext_wrong_cst2_after := by
  unfold lsb_mask_sign_zext_wrong_cst2_before lsb_mask_sign_zext_wrong_cst2_after
  simp_alive_peephole
  intros
  ---BEGIN lsb_mask_sign_zext_wrong_cst2
  apply lsb_mask_sign_zext_wrong_cst2_thm
  ---END lsb_mask_sign_zext_wrong_cst2



def lsb_mask_sign_sext_before := [llvm|
{
^0(%arg5 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(31 : i32) : i32
  %2 = llvm.add %arg5, %0 : i32
  %3 = llvm.xor %arg5, %0 : i32
  %4 = llvm.and %2, %3 : i32
  %5 = llvm.ashr %4, %1 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def lsb_mask_sign_sext_after := [llvm|
{
^0(%arg5 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "eq" %arg5, %0 : i32
  %2 = llvm.sext %1 : i1 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lsb_mask_sign_sext_proof : lsb_mask_sign_sext_before ⊑ lsb_mask_sign_sext_after := by
  unfold lsb_mask_sign_sext_before lsb_mask_sign_sext_after
  simp_alive_peephole
  intros
  ---BEGIN lsb_mask_sign_sext
  apply lsb_mask_sign_sext_thm
  ---END lsb_mask_sign_sext



def lsb_mask_sign_sext_commuted_before := [llvm|
{
^0(%arg4 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(31 : i32) : i32
  %2 = llvm.add %arg4, %0 : i32
  %3 = llvm.xor %arg4, %0 : i32
  %4 = llvm.and %3, %2 : i32
  %5 = llvm.ashr %4, %1 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def lsb_mask_sign_sext_commuted_after := [llvm|
{
^0(%arg4 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "eq" %arg4, %0 : i32
  %2 = llvm.sext %1 : i1 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lsb_mask_sign_sext_commuted_proof : lsb_mask_sign_sext_commuted_before ⊑ lsb_mask_sign_sext_commuted_after := by
  unfold lsb_mask_sign_sext_commuted_before lsb_mask_sign_sext_commuted_after
  simp_alive_peephole
  intros
  ---BEGIN lsb_mask_sign_sext_commuted
  apply lsb_mask_sign_sext_commuted_thm
  ---END lsb_mask_sign_sext_commuted



def lsb_mask_sign_sext_wrong_cst2_before := [llvm|
{
^0(%arg2 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.mlir.constant(31 : i32) : i32
  %3 = llvm.add %arg2, %0 : i32
  %4 = llvm.xor %arg2, %1 : i32
  %5 = llvm.and %3, %4 : i32
  %6 = llvm.ashr %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def lsb_mask_sign_sext_wrong_cst2_after := [llvm|
{
^0(%arg2 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(31 : i32) : i32
  %2 = llvm.add %arg2, %0 : i32
  %3 = llvm.and %2, %arg2 : i32
  %4 = llvm.ashr %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lsb_mask_sign_sext_wrong_cst2_proof : lsb_mask_sign_sext_wrong_cst2_before ⊑ lsb_mask_sign_sext_wrong_cst2_after := by
  unfold lsb_mask_sign_sext_wrong_cst2_before lsb_mask_sign_sext_wrong_cst2_after
  simp_alive_peephole
  intros
  ---BEGIN lsb_mask_sign_sext_wrong_cst2
  apply lsb_mask_sign_sext_wrong_cst2_thm
  ---END lsb_mask_sign_sext_wrong_cst2


