import SSA.Projects.InstCombine.tests.proofs.gicmphdivhconstant_proof
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
section gicmphdivhconstant_statements

def is_rem2_neg_i8_before := [llvm|
{
^0(%arg57 : i8):
  %0 = llvm.mlir.constant(2 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.srem %arg57, %0 : i8
  %3 = llvm.icmp "slt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def is_rem2_neg_i8_after := [llvm|
{
^0(%arg57 : i8):
  %0 = llvm.mlir.constant(-127 : i8) : i8
  %1 = llvm.and %arg57, %0 : i8
  %2 = llvm.icmp "eq" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem is_rem2_neg_i8_proof : is_rem2_neg_i8_before ⊑ is_rem2_neg_i8_after := by
  unfold is_rem2_neg_i8_before is_rem2_neg_i8_after
  simp_alive_peephole
  intros
  ---BEGIN is_rem2_neg_i8
  apply is_rem2_neg_i8_thm
  ---END is_rem2_neg_i8



def is_rem32_pos_i8_before := [llvm|
{
^0(%arg55 : i8):
  %0 = llvm.mlir.constant(32 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.srem %arg55, %0 : i8
  %3 = llvm.icmp "sgt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def is_rem32_pos_i8_after := [llvm|
{
^0(%arg55 : i8):
  %0 = llvm.mlir.constant(-97 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.and %arg55, %0 : i8
  %3 = llvm.icmp "sgt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem is_rem32_pos_i8_proof : is_rem32_pos_i8_before ⊑ is_rem32_pos_i8_after := by
  unfold is_rem32_pos_i8_before is_rem32_pos_i8_after
  simp_alive_peephole
  intros
  ---BEGIN is_rem32_pos_i8
  apply is_rem32_pos_i8_thm
  ---END is_rem32_pos_i8



def is_rem4_neg_i16_before := [llvm|
{
^0(%arg54 : i16):
  %0 = llvm.mlir.constant(4 : i16) : i16
  %1 = llvm.mlir.constant(0 : i16) : i16
  %2 = llvm.srem %arg54, %0 : i16
  %3 = llvm.icmp "slt" %2, %1 : i16
  "llvm.return"(%3) : (i1) -> ()
}
]
def is_rem4_neg_i16_after := [llvm|
{
^0(%arg54 : i16):
  %0 = llvm.mlir.constant(-32765 : i16) : i16
  %1 = llvm.mlir.constant(-32768 : i16) : i16
  %2 = llvm.and %arg54, %0 : i16
  %3 = llvm.icmp "ugt" %2, %1 : i16
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem is_rem4_neg_i16_proof : is_rem4_neg_i16_before ⊑ is_rem4_neg_i16_after := by
  unfold is_rem4_neg_i16_before is_rem4_neg_i16_after
  simp_alive_peephole
  intros
  ---BEGIN is_rem4_neg_i16
  apply is_rem4_neg_i16_thm
  ---END is_rem4_neg_i16



def udiv_eq_umax_before := [llvm|
{
^0(%arg42 : i8, %arg43 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.udiv %arg42, %arg43 : i8
  %2 = llvm.icmp "eq" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def udiv_eq_umax_after := [llvm|
{
^0(%arg42 : i8, %arg43 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.icmp "eq" %arg42, %0 : i8
  %3 = llvm.icmp "eq" %arg43, %1 : i8
  %4 = llvm.and %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem udiv_eq_umax_proof : udiv_eq_umax_before ⊑ udiv_eq_umax_after := by
  unfold udiv_eq_umax_before udiv_eq_umax_after
  simp_alive_peephole
  intros
  ---BEGIN udiv_eq_umax
  apply udiv_eq_umax_thm
  ---END udiv_eq_umax



def udiv_eq_big_before := [llvm|
{
^0(%arg38 : i8, %arg39 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.udiv %arg38, %arg39 : i8
  %2 = llvm.icmp "eq" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def udiv_eq_big_after := [llvm|
{
^0(%arg38 : i8, %arg39 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.icmp "eq" %arg38, %0 : i8
  %3 = llvm.icmp "eq" %arg39, %1 : i8
  %4 = llvm.and %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem udiv_eq_big_proof : udiv_eq_big_before ⊑ udiv_eq_big_after := by
  unfold udiv_eq_big_before udiv_eq_big_after
  simp_alive_peephole
  intros
  ---BEGIN udiv_eq_big
  apply udiv_eq_big_thm
  ---END udiv_eq_big



def udiv_ne_big_before := [llvm|
{
^0(%arg36 : i8, %arg37 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.udiv %arg36, %arg37 : i8
  %2 = llvm.icmp "ne" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def udiv_ne_big_after := [llvm|
{
^0(%arg36 : i8, %arg37 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.icmp "ne" %arg36, %0 : i8
  %3 = llvm.icmp "ne" %arg37, %1 : i8
  %4 = llvm.or %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem udiv_ne_big_proof : udiv_ne_big_before ⊑ udiv_ne_big_after := by
  unfold udiv_ne_big_before udiv_ne_big_after
  simp_alive_peephole
  intros
  ---BEGIN udiv_ne_big
  apply udiv_ne_big_thm
  ---END udiv_ne_big



def sdiv_eq_smin_before := [llvm|
{
^0(%arg28 : i8, %arg29 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.sdiv %arg28, %arg29 : i8
  %2 = llvm.icmp "eq" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def sdiv_eq_smin_after := [llvm|
{
^0(%arg28 : i8, %arg29 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.icmp "eq" %arg28, %0 : i8
  %3 = llvm.icmp "eq" %arg29, %1 : i8
  %4 = llvm.and %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sdiv_eq_smin_proof : sdiv_eq_smin_before ⊑ sdiv_eq_smin_after := by
  unfold sdiv_eq_smin_before sdiv_eq_smin_after
  simp_alive_peephole
  intros
  ---BEGIN sdiv_eq_smin
  apply sdiv_eq_smin_thm
  ---END sdiv_eq_smin



def sdiv_ult_smin_before := [llvm|
{
^0(%arg18 : i8, %arg19 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.sdiv %arg18, %arg19 : i8
  %2 = llvm.icmp "ult" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def sdiv_ult_smin_after := [llvm|
{
^0(%arg18 : i8, %arg19 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.sdiv %arg18, %arg19 : i8
  %2 = llvm.icmp "sgt" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sdiv_ult_smin_proof : sdiv_ult_smin_before ⊑ sdiv_ult_smin_after := by
  unfold sdiv_ult_smin_before sdiv_ult_smin_after
  simp_alive_peephole
  intros
  ---BEGIN sdiv_ult_smin
  apply sdiv_ult_smin_thm
  ---END sdiv_ult_smin



def sdiv_x_by_const_cmp_x_before := [llvm|
{
^0(%arg15 : i32):
  %0 = llvm.mlir.constant(13 : i32) : i32
  %1 = llvm.sdiv %arg15, %0 : i32
  %2 = llvm.icmp "eq" %1, %arg15 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def sdiv_x_by_const_cmp_x_after := [llvm|
{
^0(%arg15 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "eq" %arg15, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sdiv_x_by_const_cmp_x_proof : sdiv_x_by_const_cmp_x_before ⊑ sdiv_x_by_const_cmp_x_after := by
  unfold sdiv_x_by_const_cmp_x_before sdiv_x_by_const_cmp_x_after
  simp_alive_peephole
  intros
  ---BEGIN sdiv_x_by_const_cmp_x
  apply sdiv_x_by_const_cmp_x_thm
  ---END sdiv_x_by_const_cmp_x



def udiv_x_by_const_cmp_x_before := [llvm|
{
^0(%arg14 : i32):
  %0 = llvm.mlir.constant(123 : i32) : i32
  %1 = llvm.udiv %arg14, %0 : i32
  %2 = llvm.icmp "slt" %1, %arg14 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def udiv_x_by_const_cmp_x_after := [llvm|
{
^0(%arg14 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "sgt" %arg14, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem udiv_x_by_const_cmp_x_proof : udiv_x_by_const_cmp_x_before ⊑ udiv_x_by_const_cmp_x_after := by
  unfold udiv_x_by_const_cmp_x_before udiv_x_by_const_cmp_x_after
  simp_alive_peephole
  intros
  ---BEGIN udiv_x_by_const_cmp_x
  apply udiv_x_by_const_cmp_x_thm
  ---END udiv_x_by_const_cmp_x



def lshr_x_by_const_cmp_x_before := [llvm|
{
^0(%arg11 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.lshr %arg11, %0 : i32
  %2 = llvm.icmp "eq" %1, %arg11 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def lshr_x_by_const_cmp_x_after := [llvm|
{
^0(%arg11 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "eq" %arg11, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_x_by_const_cmp_x_proof : lshr_x_by_const_cmp_x_before ⊑ lshr_x_by_const_cmp_x_after := by
  unfold lshr_x_by_const_cmp_x_before lshr_x_by_const_cmp_x_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_x_by_const_cmp_x
  apply lshr_x_by_const_cmp_x_thm
  ---END lshr_x_by_const_cmp_x



def lshr_by_const_cmp_sge_value_before := [llvm|
{
^0(%arg7 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.lshr %arg7, %0 : i32
  %2 = llvm.icmp "sge" %1, %arg7 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def lshr_by_const_cmp_sge_value_after := [llvm|
{
^0(%arg7 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.icmp "slt" %arg7, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_by_const_cmp_sge_value_proof : lshr_by_const_cmp_sge_value_before ⊑ lshr_by_const_cmp_sge_value_after := by
  unfold lshr_by_const_cmp_sge_value_before lshr_by_const_cmp_sge_value_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_by_const_cmp_sge_value
  apply lshr_by_const_cmp_sge_value_thm
  ---END lshr_by_const_cmp_sge_value



def ashr_x_by_const_cmp_sge_x_before := [llvm|
{
^0(%arg6 : i32):
  %0 = llvm.mlir.constant(5 : i32) : i32
  %1 = llvm.ashr %arg6, %0 : i32
  %2 = llvm.icmp "sge" %1, %arg6 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def ashr_x_by_const_cmp_sge_x_after := [llvm|
{
^0(%arg6 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.icmp "slt" %arg6, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_x_by_const_cmp_sge_x_proof : ashr_x_by_const_cmp_sge_x_before ⊑ ashr_x_by_const_cmp_sge_x_after := by
  unfold ashr_x_by_const_cmp_sge_x_before ashr_x_by_const_cmp_sge_x_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_x_by_const_cmp_sge_x
  apply ashr_x_by_const_cmp_sge_x_thm
  ---END ashr_x_by_const_cmp_sge_x


