import SSA.Projects.InstCombine.tests.proofs.gicmphor_proof
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
section gicmphor_statements

def set_low_bit_mask_eq_before := [llvm|
{
^0(%arg211 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(19 : i8) : i8
  %2 = llvm.or %arg211, %0 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def set_low_bit_mask_eq_after := [llvm|
{
^0(%arg211 : i8):
  %0 = llvm.mlir.constant(-2 : i8) : i8
  %1 = llvm.mlir.constant(18 : i8) : i8
  %2 = llvm.and %arg211, %0 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem set_low_bit_mask_eq_proof : set_low_bit_mask_eq_before ⊑ set_low_bit_mask_eq_after := by
  unfold set_low_bit_mask_eq_before set_low_bit_mask_eq_after
  simp_alive_peephole
  intros
  ---BEGIN set_low_bit_mask_eq
  apply set_low_bit_mask_eq_thm
  ---END set_low_bit_mask_eq



def set_low_bit_mask_ugt_before := [llvm|
{
^0(%arg209 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(19 : i8) : i8
  %2 = llvm.or %arg209, %0 : i8
  %3 = llvm.icmp "ugt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def set_low_bit_mask_ugt_after := [llvm|
{
^0(%arg209 : i8):
  %0 = llvm.mlir.constant(19 : i8) : i8
  %1 = llvm.icmp "ugt" %arg209, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem set_low_bit_mask_ugt_proof : set_low_bit_mask_ugt_before ⊑ set_low_bit_mask_ugt_after := by
  unfold set_low_bit_mask_ugt_before set_low_bit_mask_ugt_after
  simp_alive_peephole
  intros
  ---BEGIN set_low_bit_mask_ugt
  apply set_low_bit_mask_ugt_thm
  ---END set_low_bit_mask_ugt



def set_low_bit_mask_uge_before := [llvm|
{
^0(%arg207 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(20 : i8) : i8
  %2 = llvm.or %arg207, %0 : i8
  %3 = llvm.icmp "uge" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def set_low_bit_mask_uge_after := [llvm|
{
^0(%arg207 : i8):
  %0 = llvm.mlir.constant(19 : i8) : i8
  %1 = llvm.icmp "ugt" %arg207, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem set_low_bit_mask_uge_proof : set_low_bit_mask_uge_before ⊑ set_low_bit_mask_uge_after := by
  unfold set_low_bit_mask_uge_before set_low_bit_mask_uge_after
  simp_alive_peephole
  intros
  ---BEGIN set_low_bit_mask_uge
  apply set_low_bit_mask_uge_thm
  ---END set_low_bit_mask_uge



def set_low_bit_mask_ule_before := [llvm|
{
^0(%arg206 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(18 : i8) : i8
  %2 = llvm.or %arg206, %0 : i8
  %3 = llvm.icmp "ule" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def set_low_bit_mask_ule_after := [llvm|
{
^0(%arg206 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(19 : i8) : i8
  %2 = llvm.or %arg206, %0 : i8
  %3 = llvm.icmp "ult" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem set_low_bit_mask_ule_proof : set_low_bit_mask_ule_before ⊑ set_low_bit_mask_ule_after := by
  unfold set_low_bit_mask_ule_before set_low_bit_mask_ule_after
  simp_alive_peephole
  intros
  ---BEGIN set_low_bit_mask_ule
  apply set_low_bit_mask_ule_thm
  ---END set_low_bit_mask_ule



def set_low_bit_mask_sge_before := [llvm|
{
^0(%arg203 : i8):
  %0 = llvm.mlir.constant(31 : i8) : i8
  %1 = llvm.mlir.constant(51 : i8) : i8
  %2 = llvm.or %arg203, %0 : i8
  %3 = llvm.icmp "sge" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def set_low_bit_mask_sge_after := [llvm|
{
^0(%arg203 : i8):
  %0 = llvm.mlir.constant(31 : i8) : i8
  %1 = llvm.mlir.constant(50 : i8) : i8
  %2 = llvm.or %arg203, %0 : i8
  %3 = llvm.icmp "sgt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem set_low_bit_mask_sge_proof : set_low_bit_mask_sge_before ⊑ set_low_bit_mask_sge_after := by
  unfold set_low_bit_mask_sge_before set_low_bit_mask_sge_after
  simp_alive_peephole
  intros
  ---BEGIN set_low_bit_mask_sge
  apply set_low_bit_mask_sge_thm
  ---END set_low_bit_mask_sge



def set_low_bit_mask_sle_before := [llvm|
{
^0(%arg202 : i8):
  %0 = llvm.mlir.constant(63 : i8) : i8
  %1 = llvm.mlir.constant(68 : i8) : i8
  %2 = llvm.or %arg202, %0 : i8
  %3 = llvm.icmp "sle" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def set_low_bit_mask_sle_after := [llvm|
{
^0(%arg202 : i8):
  %0 = llvm.mlir.constant(63 : i8) : i8
  %1 = llvm.mlir.constant(69 : i8) : i8
  %2 = llvm.or %arg202, %0 : i8
  %3 = llvm.icmp "slt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem set_low_bit_mask_sle_proof : set_low_bit_mask_sle_before ⊑ set_low_bit_mask_sle_after := by
  unfold set_low_bit_mask_sle_before set_low_bit_mask_sle_after
  simp_alive_peephole
  intros
  ---BEGIN set_low_bit_mask_sle
  apply set_low_bit_mask_sle_thm
  ---END set_low_bit_mask_sle



def eq_const_mask_before := [llvm|
{
^0(%arg200 : i8, %arg201 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.or %arg200, %0 : i8
  %2 = llvm.or %arg201, %0 : i8
  %3 = llvm.icmp "eq" %1, %2 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def eq_const_mask_after := [llvm|
{
^0(%arg200 : i8, %arg201 : i8):
  %0 = llvm.mlir.constant(-43 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.xor %arg200, %arg201 : i8
  %3 = llvm.and %2, %0 : i8
  %4 = llvm.icmp "eq" %3, %1 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem eq_const_mask_proof : eq_const_mask_before ⊑ eq_const_mask_after := by
  unfold eq_const_mask_before eq_const_mask_after
  simp_alive_peephole
  intros
  ---BEGIN eq_const_mask
  apply eq_const_mask_thm
  ---END eq_const_mask



def eq_const_mask_wrong_opcode_before := [llvm|
{
^0(%arg192 : i8, %arg193 : i8):
  %0 = llvm.mlir.constant(5 : i8) : i8
  %1 = llvm.or %arg192, %0 : i8
  %2 = llvm.xor %arg193, %0 : i8
  %3 = llvm.icmp "eq" %1, %2 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def eq_const_mask_wrong_opcode_after := [llvm|
{
^0(%arg192 : i8, %arg193 : i8):
  %0 = llvm.mlir.constant(5 : i8) : i8
  %1 = llvm.or %arg192, %0 : i8
  %2 = llvm.xor %arg193, %1 : i8
  %3 = llvm.icmp "eq" %2, %0 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem eq_const_mask_wrong_opcode_proof : eq_const_mask_wrong_opcode_before ⊑ eq_const_mask_wrong_opcode_after := by
  unfold eq_const_mask_wrong_opcode_before eq_const_mask_wrong_opcode_after
  simp_alive_peephole
  intros
  ---BEGIN eq_const_mask_wrong_opcode
  apply eq_const_mask_wrong_opcode_thm
  ---END eq_const_mask_wrong_opcode



def icmp_or_xor_2_eq_before := [llvm|
{
^0(%arg174 : i64, %arg175 : i64, %arg176 : i64, %arg177 : i64):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.xor %arg174, %arg175 : i64
  %2 = llvm.xor %arg176, %arg177 : i64
  %3 = llvm.or %1, %2 : i64
  %4 = llvm.icmp "eq" %3, %0 : i64
  "llvm.return"(%4) : (i1) -> ()
}
]
def icmp_or_xor_2_eq_after := [llvm|
{
^0(%arg174 : i64, %arg175 : i64, %arg176 : i64, %arg177 : i64):
  %0 = llvm.icmp "eq" %arg174, %arg175 : i64
  %1 = llvm.icmp "eq" %arg176, %arg177 : i64
  %2 = llvm.and %0, %1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_or_xor_2_eq_proof : icmp_or_xor_2_eq_before ⊑ icmp_or_xor_2_eq_after := by
  unfold icmp_or_xor_2_eq_before icmp_or_xor_2_eq_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_or_xor_2_eq
  apply icmp_or_xor_2_eq_thm
  ---END icmp_or_xor_2_eq



def icmp_or_xor_2_ne_before := [llvm|
{
^0(%arg170 : i64, %arg171 : i64, %arg172 : i64, %arg173 : i64):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.xor %arg170, %arg171 : i64
  %2 = llvm.xor %arg172, %arg173 : i64
  %3 = llvm.or %1, %2 : i64
  %4 = llvm.icmp "ne" %3, %0 : i64
  "llvm.return"(%4) : (i1) -> ()
}
]
def icmp_or_xor_2_ne_after := [llvm|
{
^0(%arg170 : i64, %arg171 : i64, %arg172 : i64, %arg173 : i64):
  %0 = llvm.icmp "ne" %arg170, %arg171 : i64
  %1 = llvm.icmp "ne" %arg172, %arg173 : i64
  %2 = llvm.or %0, %1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_or_xor_2_ne_proof : icmp_or_xor_2_ne_before ⊑ icmp_or_xor_2_ne_after := by
  unfold icmp_or_xor_2_ne_before icmp_or_xor_2_ne_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_or_xor_2_ne
  apply icmp_or_xor_2_ne_thm
  ---END icmp_or_xor_2_ne



def icmp_or_xor_2_3_fail_before := [llvm|
{
^0(%arg158 : i64, %arg159 : i64, %arg160 : i64, %arg161 : i64):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.xor %arg158, %arg159 : i64
  %2 = llvm.xor %arg160, %arg161 : i64
  %3 = llvm.or %1, %2 : i64
  %4 = llvm.icmp "eq" %3, %0 : i64
  %5 = llvm.icmp "eq" %1, %0 : i64
  %6 = llvm.or %4, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def icmp_or_xor_2_3_fail_after := [llvm|
{
^0(%arg158 : i64, %arg159 : i64, %arg160 : i64, %arg161 : i64):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.xor %arg158, %arg159 : i64
  %2 = llvm.xor %arg160, %arg161 : i64
  %3 = llvm.or %1, %2 : i64
  %4 = llvm.icmp "eq" %3, %0 : i64
  %5 = llvm.icmp "eq" %arg158, %arg159 : i64
  %6 = llvm.or %4, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_or_xor_2_3_fail_proof : icmp_or_xor_2_3_fail_before ⊑ icmp_or_xor_2_3_fail_after := by
  unfold icmp_or_xor_2_3_fail_before icmp_or_xor_2_3_fail_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_or_xor_2_3_fail
  apply icmp_or_xor_2_3_fail_thm
  ---END icmp_or_xor_2_3_fail



def icmp_or_xor_2_4_fail_before := [llvm|
{
^0(%arg154 : i64, %arg155 : i64, %arg156 : i64, %arg157 : i64):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.xor %arg154, %arg155 : i64
  %2 = llvm.xor %arg156, %arg157 : i64
  %3 = llvm.or %1, %2 : i64
  %4 = llvm.icmp "eq" %3, %0 : i64
  %5 = llvm.icmp "eq" %2, %0 : i64
  %6 = llvm.or %4, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def icmp_or_xor_2_4_fail_after := [llvm|
{
^0(%arg154 : i64, %arg155 : i64, %arg156 : i64, %arg157 : i64):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.xor %arg154, %arg155 : i64
  %2 = llvm.xor %arg156, %arg157 : i64
  %3 = llvm.or %1, %2 : i64
  %4 = llvm.icmp "eq" %3, %0 : i64
  %5 = llvm.icmp "eq" %arg156, %arg157 : i64
  %6 = llvm.or %4, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_or_xor_2_4_fail_proof : icmp_or_xor_2_4_fail_before ⊑ icmp_or_xor_2_4_fail_after := by
  unfold icmp_or_xor_2_4_fail_before icmp_or_xor_2_4_fail_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_or_xor_2_4_fail
  apply icmp_or_xor_2_4_fail_thm
  ---END icmp_or_xor_2_4_fail

#exit -- This times out

def icmp_or_xor_3_1_before := [llvm|
{
^0(%arg148 : i64, %arg149 : i64, %arg150 : i64, %arg151 : i64, %arg152 : i64, %arg153 : i64):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.xor %arg148, %arg149 : i64
  %2 = llvm.xor %arg150, %arg151 : i64
  %3 = llvm.or %1, %2 : i64
  %4 = llvm.xor %arg152, %arg153 : i64
  %5 = llvm.or %3, %4 : i64
  %6 = llvm.icmp "eq" %5, %0 : i64
  "llvm.return"(%6) : (i1) -> ()
}
]
def icmp_or_xor_3_1_after := [llvm|
{
^0(%arg148 : i64, %arg149 : i64, %arg150 : i64, %arg151 : i64, %arg152 : i64, %arg153 : i64):
  %0 = llvm.icmp "eq" %arg148, %arg149 : i64
  %1 = llvm.icmp "eq" %arg150, %arg151 : i64
  %2 = llvm.and %0, %1 : i1
  %3 = llvm.icmp "eq" %arg152, %arg153 : i64
  %4 = llvm.and %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_or_xor_3_1_proof : icmp_or_xor_3_1_before ⊑ icmp_or_xor_3_1_after := by
  unfold icmp_or_xor_3_1_before icmp_or_xor_3_1_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_or_xor_3_1
  all_goals (try extract_goal ; sorry)
  ---END icmp_or_xor_3_1



def icmp_or_xor_3_3_before := [llvm|
{
^0(%arg136 : i64, %arg137 : i64, %arg138 : i64, %arg139 : i64, %arg140 : i64, %arg141 : i64):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.xor %arg136, %arg137 : i64
  %2 = llvm.xor %arg138, %arg139 : i64
  %3 = llvm.or %1, %2 : i64
  %4 = llvm.xor %arg140, %arg141 : i64
  %5 = llvm.or %4, %3 : i64
  %6 = llvm.icmp "eq" %5, %0 : i64
  "llvm.return"(%6) : (i1) -> ()
}
]
def icmp_or_xor_3_3_after := [llvm|
{
^0(%arg136 : i64, %arg137 : i64, %arg138 : i64, %arg139 : i64, %arg140 : i64, %arg141 : i64):
  %0 = llvm.icmp "eq" %arg136, %arg137 : i64
  %1 = llvm.icmp "eq" %arg138, %arg139 : i64
  %2 = llvm.and %0, %1 : i1
  %3 = llvm.icmp "eq" %arg140, %arg141 : i64
  %4 = llvm.and %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_or_xor_3_3_proof : icmp_or_xor_3_3_before ⊑ icmp_or_xor_3_3_after := by
  unfold icmp_or_xor_3_3_before icmp_or_xor_3_3_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_or_xor_3_3
  all_goals (try extract_goal ; sorry)
  ---END icmp_or_xor_3_3



def icmp_or_xor_4_1_before := [llvm|
{
^0(%arg122 : i64, %arg123 : i64, %arg124 : i64, %arg125 : i64, %arg126 : i64, %arg127 : i64, %arg128 : i64, %arg129 : i64):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.xor %arg122, %arg123 : i64
  %2 = llvm.xor %arg124, %arg125 : i64
  %3 = llvm.or %1, %2 : i64
  %4 = llvm.xor %arg126, %arg127 : i64
  %5 = llvm.xor %arg128, %arg129 : i64
  %6 = llvm.or %4, %5 : i64
  %7 = llvm.or %3, %6 : i64
  %8 = llvm.icmp "eq" %7, %0 : i64
  "llvm.return"(%8) : (i1) -> ()
}
]
def icmp_or_xor_4_1_after := [llvm|
{
^0(%arg122 : i64, %arg123 : i64, %arg124 : i64, %arg125 : i64, %arg126 : i64, %arg127 : i64, %arg128 : i64, %arg129 : i64):
  %0 = llvm.icmp "eq" %arg126, %arg127 : i64
  %1 = llvm.icmp "eq" %arg128, %arg129 : i64
  %2 = llvm.and %0, %1 : i1
  %3 = llvm.icmp "eq" %arg122, %arg123 : i64
  %4 = llvm.and %2, %3 : i1
  %5 = llvm.icmp "eq" %arg124, %arg125 : i64
  %6 = llvm.and %4, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_or_xor_4_1_proof : icmp_or_xor_4_1_before ⊑ icmp_or_xor_4_1_after := by
  unfold icmp_or_xor_4_1_before icmp_or_xor_4_1_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_or_xor_4_1
  all_goals (try extract_goal ; sorry)
  ---END icmp_or_xor_4_1



def icmp_or_xor_4_2_before := [llvm|
{
^0(%arg114 : i64, %arg115 : i64, %arg116 : i64, %arg117 : i64, %arg118 : i64, %arg119 : i64, %arg120 : i64, %arg121 : i64):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.xor %arg114, %arg115 : i64
  %2 = llvm.xor %arg116, %arg117 : i64
  %3 = llvm.or %1, %2 : i64
  %4 = llvm.xor %arg118, %arg119 : i64
  %5 = llvm.xor %arg120, %arg121 : i64
  %6 = llvm.or %4, %5 : i64
  %7 = llvm.or %6, %3 : i64
  %8 = llvm.icmp "eq" %7, %0 : i64
  "llvm.return"(%8) : (i1) -> ()
}
]
def icmp_or_xor_4_2_after := [llvm|
{
^0(%arg114 : i64, %arg115 : i64, %arg116 : i64, %arg117 : i64, %arg118 : i64, %arg119 : i64, %arg120 : i64, %arg121 : i64):
  %0 = llvm.icmp "eq" %arg114, %arg115 : i64
  %1 = llvm.icmp "eq" %arg116, %arg117 : i64
  %2 = llvm.and %0, %1 : i1
  %3 = llvm.icmp "eq" %arg118, %arg119 : i64
  %4 = llvm.and %2, %3 : i1
  %5 = llvm.icmp "eq" %arg120, %arg121 : i64
  %6 = llvm.and %4, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_or_xor_4_2_proof : icmp_or_xor_4_2_before ⊑ icmp_or_xor_4_2_after := by
  unfold icmp_or_xor_4_2_before icmp_or_xor_4_2_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_or_xor_4_2
  all_goals (try extract_goal ; sorry)
  ---END icmp_or_xor_4_2



def icmp_or_sub_2_eq_before := [llvm|
{
^0(%arg110 : i64, %arg111 : i64, %arg112 : i64, %arg113 : i64):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.sub %arg110, %arg111 : i64
  %2 = llvm.sub %arg112, %arg113 : i64
  %3 = llvm.or %1, %2 : i64
  %4 = llvm.icmp "eq" %3, %0 : i64
  "llvm.return"(%4) : (i1) -> ()
}
]
def icmp_or_sub_2_eq_after := [llvm|
{
^0(%arg110 : i64, %arg111 : i64, %arg112 : i64, %arg113 : i64):
  %0 = llvm.icmp "eq" %arg110, %arg111 : i64
  %1 = llvm.icmp "eq" %arg112, %arg113 : i64
  %2 = llvm.and %0, %1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_or_sub_2_eq_proof : icmp_or_sub_2_eq_before ⊑ icmp_or_sub_2_eq_after := by
  unfold icmp_or_sub_2_eq_before icmp_or_sub_2_eq_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_or_sub_2_eq
  all_goals (try extract_goal ; sorry)
  ---END icmp_or_sub_2_eq



def icmp_or_sub_2_ne_before := [llvm|
{
^0(%arg106 : i64, %arg107 : i64, %arg108 : i64, %arg109 : i64):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.sub %arg106, %arg107 : i64
  %2 = llvm.sub %arg108, %arg109 : i64
  %3 = llvm.or %1, %2 : i64
  %4 = llvm.icmp "ne" %3, %0 : i64
  "llvm.return"(%4) : (i1) -> ()
}
]
def icmp_or_sub_2_ne_after := [llvm|
{
^0(%arg106 : i64, %arg107 : i64, %arg108 : i64, %arg109 : i64):
  %0 = llvm.icmp "ne" %arg106, %arg107 : i64
  %1 = llvm.icmp "ne" %arg108, %arg109 : i64
  %2 = llvm.or %0, %1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_or_sub_2_ne_proof : icmp_or_sub_2_ne_before ⊑ icmp_or_sub_2_ne_after := by
  unfold icmp_or_sub_2_ne_before icmp_or_sub_2_ne_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_or_sub_2_ne
  all_goals (try extract_goal ; sorry)
  ---END icmp_or_sub_2_ne



def icmp_or_sub_3_1_before := [llvm|
{
^0(%arg84 : i64, %arg85 : i64, %arg86 : i64, %arg87 : i64, %arg88 : i64, %arg89 : i64):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.sub %arg84, %arg85 : i64
  %2 = llvm.sub %arg86, %arg87 : i64
  %3 = llvm.or %1, %2 : i64
  %4 = llvm.sub %arg88, %arg89 : i64
  %5 = llvm.or %3, %4 : i64
  %6 = llvm.icmp "eq" %5, %0 : i64
  "llvm.return"(%6) : (i1) -> ()
}
]
def icmp_or_sub_3_1_after := [llvm|
{
^0(%arg84 : i64, %arg85 : i64, %arg86 : i64, %arg87 : i64, %arg88 : i64, %arg89 : i64):
  %0 = llvm.icmp "eq" %arg84, %arg85 : i64
  %1 = llvm.icmp "eq" %arg86, %arg87 : i64
  %2 = llvm.and %0, %1 : i1
  %3 = llvm.icmp "eq" %arg88, %arg89 : i64
  %4 = llvm.and %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_or_sub_3_1_proof : icmp_or_sub_3_1_before ⊑ icmp_or_sub_3_1_after := by
  unfold icmp_or_sub_3_1_before icmp_or_sub_3_1_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_or_sub_3_1
  all_goals (try extract_goal ; sorry)
  ---END icmp_or_sub_3_1



def icmp_or_sub_3_3_before := [llvm|
{
^0(%arg72 : i64, %arg73 : i64, %arg74 : i64, %arg75 : i64, %arg76 : i64, %arg77 : i64):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.sub %arg72, %arg73 : i64
  %2 = llvm.sub %arg74, %arg75 : i64
  %3 = llvm.or %1, %2 : i64
  %4 = llvm.sub %arg76, %arg77 : i64
  %5 = llvm.or %4, %3 : i64
  %6 = llvm.icmp "eq" %5, %0 : i64
  "llvm.return"(%6) : (i1) -> ()
}
]
def icmp_or_sub_3_3_after := [llvm|
{
^0(%arg72 : i64, %arg73 : i64, %arg74 : i64, %arg75 : i64, %arg76 : i64, %arg77 : i64):
  %0 = llvm.icmp "eq" %arg72, %arg73 : i64
  %1 = llvm.icmp "eq" %arg74, %arg75 : i64
  %2 = llvm.and %0, %1 : i1
  %3 = llvm.icmp "eq" %arg76, %arg77 : i64
  %4 = llvm.and %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_or_sub_3_3_proof : icmp_or_sub_3_3_before ⊑ icmp_or_sub_3_3_after := by
  unfold icmp_or_sub_3_3_before icmp_or_sub_3_3_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_or_sub_3_3
  all_goals (try extract_goal ; sorry)
  ---END icmp_or_sub_3_3



def icmp_or_sub_4_1_before := [llvm|
{
^0(%arg58 : i64, %arg59 : i64, %arg60 : i64, %arg61 : i64, %arg62 : i64, %arg63 : i64, %arg64 : i64, %arg65 : i64):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.sub %arg58, %arg59 : i64
  %2 = llvm.sub %arg60, %arg61 : i64
  %3 = llvm.or %1, %2 : i64
  %4 = llvm.sub %arg62, %arg63 : i64
  %5 = llvm.sub %arg64, %arg65 : i64
  %6 = llvm.or %4, %5 : i64
  %7 = llvm.or %3, %6 : i64
  %8 = llvm.icmp "eq" %7, %0 : i64
  "llvm.return"(%8) : (i1) -> ()
}
]
def icmp_or_sub_4_1_after := [llvm|
{
^0(%arg58 : i64, %arg59 : i64, %arg60 : i64, %arg61 : i64, %arg62 : i64, %arg63 : i64, %arg64 : i64, %arg65 : i64):
  %0 = llvm.icmp "eq" %arg62, %arg63 : i64
  %1 = llvm.icmp "eq" %arg64, %arg65 : i64
  %2 = llvm.and %0, %1 : i1
  %3 = llvm.icmp "eq" %arg58, %arg59 : i64
  %4 = llvm.and %2, %3 : i1
  %5 = llvm.icmp "eq" %arg60, %arg61 : i64
  %6 = llvm.and %4, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_or_sub_4_1_proof : icmp_or_sub_4_1_before ⊑ icmp_or_sub_4_1_after := by
  unfold icmp_or_sub_4_1_before icmp_or_sub_4_1_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_or_sub_4_1
  all_goals (try extract_goal ; sorry)
  ---END icmp_or_sub_4_1



def icmp_or_sub_4_2_before := [llvm|
{
^0(%arg50 : i64, %arg51 : i64, %arg52 : i64, %arg53 : i64, %arg54 : i64, %arg55 : i64, %arg56 : i64, %arg57 : i64):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.sub %arg50, %arg51 : i64
  %2 = llvm.sub %arg52, %arg53 : i64
  %3 = llvm.or %1, %2 : i64
  %4 = llvm.sub %arg54, %arg55 : i64
  %5 = llvm.sub %arg56, %arg57 : i64
  %6 = llvm.or %4, %5 : i64
  %7 = llvm.or %6, %3 : i64
  %8 = llvm.icmp "eq" %7, %0 : i64
  "llvm.return"(%8) : (i1) -> ()
}
]
def icmp_or_sub_4_2_after := [llvm|
{
^0(%arg50 : i64, %arg51 : i64, %arg52 : i64, %arg53 : i64, %arg54 : i64, %arg55 : i64, %arg56 : i64, %arg57 : i64):
  %0 = llvm.icmp "eq" %arg50, %arg51 : i64
  %1 = llvm.icmp "eq" %arg52, %arg53 : i64
  %2 = llvm.and %0, %1 : i1
  %3 = llvm.icmp "eq" %arg54, %arg55 : i64
  %4 = llvm.and %2, %3 : i1
  %5 = llvm.icmp "eq" %arg56, %arg57 : i64
  %6 = llvm.and %4, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_or_sub_4_2_proof : icmp_or_sub_4_2_before ⊑ icmp_or_sub_4_2_after := by
  unfold icmp_or_sub_4_2_before icmp_or_sub_4_2_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_or_sub_4_2
  all_goals (try extract_goal ; sorry)
  ---END icmp_or_sub_4_2



def icmp_or_xor_with_sub_2_eq_before := [llvm|
{
^0(%arg46 : i64, %arg47 : i64, %arg48 : i64, %arg49 : i64):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.xor %arg46, %arg47 : i64
  %2 = llvm.sub %arg48, %arg49 : i64
  %3 = llvm.or %1, %2 : i64
  %4 = llvm.icmp "eq" %3, %0 : i64
  "llvm.return"(%4) : (i1) -> ()
}
]
def icmp_or_xor_with_sub_2_eq_after := [llvm|
{
^0(%arg46 : i64, %arg47 : i64, %arg48 : i64, %arg49 : i64):
  %0 = llvm.icmp "eq" %arg46, %arg47 : i64
  %1 = llvm.icmp "eq" %arg48, %arg49 : i64
  %2 = llvm.and %0, %1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_or_xor_with_sub_2_eq_proof : icmp_or_xor_with_sub_2_eq_before ⊑ icmp_or_xor_with_sub_2_eq_after := by
  unfold icmp_or_xor_with_sub_2_eq_before icmp_or_xor_with_sub_2_eq_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_or_xor_with_sub_2_eq
  all_goals (try extract_goal ; sorry)
  ---END icmp_or_xor_with_sub_2_eq



def icmp_or_xor_with_sub_2_ne_before := [llvm|
{
^0(%arg42 : i64, %arg43 : i64, %arg44 : i64, %arg45 : i64):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.xor %arg42, %arg43 : i64
  %2 = llvm.sub %arg44, %arg45 : i64
  %3 = llvm.or %1, %2 : i64
  %4 = llvm.icmp "ne" %3, %0 : i64
  "llvm.return"(%4) : (i1) -> ()
}
]
def icmp_or_xor_with_sub_2_ne_after := [llvm|
{
^0(%arg42 : i64, %arg43 : i64, %arg44 : i64, %arg45 : i64):
  %0 = llvm.icmp "ne" %arg42, %arg43 : i64
  %1 = llvm.icmp "ne" %arg44, %arg45 : i64
  %2 = llvm.or %0, %1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_or_xor_with_sub_2_ne_proof : icmp_or_xor_with_sub_2_ne_before ⊑ icmp_or_xor_with_sub_2_ne_after := by
  unfold icmp_or_xor_with_sub_2_ne_before icmp_or_xor_with_sub_2_ne_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_or_xor_with_sub_2_ne
  all_goals (try extract_goal ; sorry)
  ---END icmp_or_xor_with_sub_2_ne



def icmp_or_xor_with_sub_3_1_before := [llvm|
{
^0(%arg36 : i64, %arg37 : i64, %arg38 : i64, %arg39 : i64, %arg40 : i64, %arg41 : i64):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.xor %arg36, %arg37 : i64
  %2 = llvm.xor %arg38, %arg39 : i64
  %3 = llvm.or %1, %2 : i64
  %4 = llvm.sub %arg40, %arg41 : i64
  %5 = llvm.or %3, %4 : i64
  %6 = llvm.icmp "eq" %5, %0 : i64
  "llvm.return"(%6) : (i1) -> ()
}
]
def icmp_or_xor_with_sub_3_1_after := [llvm|
{
^0(%arg36 : i64, %arg37 : i64, %arg38 : i64, %arg39 : i64, %arg40 : i64, %arg41 : i64):
  %0 = llvm.icmp "eq" %arg36, %arg37 : i64
  %1 = llvm.icmp "eq" %arg38, %arg39 : i64
  %2 = llvm.and %0, %1 : i1
  %3 = llvm.icmp "eq" %arg40, %arg41 : i64
  %4 = llvm.and %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_or_xor_with_sub_3_1_proof : icmp_or_xor_with_sub_3_1_before ⊑ icmp_or_xor_with_sub_3_1_after := by
  unfold icmp_or_xor_with_sub_3_1_before icmp_or_xor_with_sub_3_1_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_or_xor_with_sub_3_1
  all_goals (try extract_goal ; sorry)
  ---END icmp_or_xor_with_sub_3_1



def icmp_or_xor_with_sub_3_2_before := [llvm|
{
^0(%arg30 : i64, %arg31 : i64, %arg32 : i64, %arg33 : i64, %arg34 : i64, %arg35 : i64):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.xor %arg30, %arg31 : i64
  %2 = llvm.sub %arg32, %arg33 : i64
  %3 = llvm.or %1, %2 : i64
  %4 = llvm.xor %arg34, %arg35 : i64
  %5 = llvm.or %3, %4 : i64
  %6 = llvm.icmp "eq" %5, %0 : i64
  "llvm.return"(%6) : (i1) -> ()
}
]
def icmp_or_xor_with_sub_3_2_after := [llvm|
{
^0(%arg30 : i64, %arg31 : i64, %arg32 : i64, %arg33 : i64, %arg34 : i64, %arg35 : i64):
  %0 = llvm.icmp "eq" %arg30, %arg31 : i64
  %1 = llvm.icmp "eq" %arg32, %arg33 : i64
  %2 = llvm.and %0, %1 : i1
  %3 = llvm.icmp "eq" %arg34, %arg35 : i64
  %4 = llvm.and %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_or_xor_with_sub_3_2_proof : icmp_or_xor_with_sub_3_2_before ⊑ icmp_or_xor_with_sub_3_2_after := by
  unfold icmp_or_xor_with_sub_3_2_before icmp_or_xor_with_sub_3_2_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_or_xor_with_sub_3_2
  all_goals (try extract_goal ; sorry)
  ---END icmp_or_xor_with_sub_3_2



def icmp_or_xor_with_sub_3_3_before := [llvm|
{
^0(%arg24 : i64, %arg25 : i64, %arg26 : i64, %arg27 : i64, %arg28 : i64, %arg29 : i64):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.xor %arg24, %arg25 : i64
  %2 = llvm.sub %arg26, %arg27 : i64
  %3 = llvm.or %1, %2 : i64
  %4 = llvm.sub %arg28, %arg29 : i64
  %5 = llvm.or %3, %4 : i64
  %6 = llvm.icmp "eq" %5, %0 : i64
  "llvm.return"(%6) : (i1) -> ()
}
]
def icmp_or_xor_with_sub_3_3_after := [llvm|
{
^0(%arg24 : i64, %arg25 : i64, %arg26 : i64, %arg27 : i64, %arg28 : i64, %arg29 : i64):
  %0 = llvm.icmp "eq" %arg24, %arg25 : i64
  %1 = llvm.icmp "eq" %arg26, %arg27 : i64
  %2 = llvm.and %0, %1 : i1
  %3 = llvm.icmp "eq" %arg28, %arg29 : i64
  %4 = llvm.and %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_or_xor_with_sub_3_3_proof : icmp_or_xor_with_sub_3_3_before ⊑ icmp_or_xor_with_sub_3_3_after := by
  unfold icmp_or_xor_with_sub_3_3_before icmp_or_xor_with_sub_3_3_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_or_xor_with_sub_3_3
  all_goals (try extract_goal ; sorry)
  ---END icmp_or_xor_with_sub_3_3



def icmp_or_xor_with_sub_3_4_before := [llvm|
{
^0(%arg18 : i64, %arg19 : i64, %arg20 : i64, %arg21 : i64, %arg22 : i64, %arg23 : i64):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.sub %arg18, %arg19 : i64
  %2 = llvm.xor %arg20, %arg21 : i64
  %3 = llvm.or %1, %2 : i64
  %4 = llvm.xor %arg22, %arg23 : i64
  %5 = llvm.or %3, %4 : i64
  %6 = llvm.icmp "eq" %5, %0 : i64
  "llvm.return"(%6) : (i1) -> ()
}
]
def icmp_or_xor_with_sub_3_4_after := [llvm|
{
^0(%arg18 : i64, %arg19 : i64, %arg20 : i64, %arg21 : i64, %arg22 : i64, %arg23 : i64):
  %0 = llvm.icmp "eq" %arg18, %arg19 : i64
  %1 = llvm.icmp "eq" %arg20, %arg21 : i64
  %2 = llvm.and %0, %1 : i1
  %3 = llvm.icmp "eq" %arg22, %arg23 : i64
  %4 = llvm.and %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_or_xor_with_sub_3_4_proof : icmp_or_xor_with_sub_3_4_before ⊑ icmp_or_xor_with_sub_3_4_after := by
  unfold icmp_or_xor_with_sub_3_4_before icmp_or_xor_with_sub_3_4_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_or_xor_with_sub_3_4
  all_goals (try extract_goal ; sorry)
  ---END icmp_or_xor_with_sub_3_4



def icmp_or_xor_with_sub_3_5_before := [llvm|
{
^0(%arg12 : i64, %arg13 : i64, %arg14 : i64, %arg15 : i64, %arg16 : i64, %arg17 : i64):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.sub %arg12, %arg13 : i64
  %2 = llvm.xor %arg14, %arg15 : i64
  %3 = llvm.or %1, %2 : i64
  %4 = llvm.sub %arg16, %arg17 : i64
  %5 = llvm.or %3, %4 : i64
  %6 = llvm.icmp "eq" %5, %0 : i64
  "llvm.return"(%6) : (i1) -> ()
}
]
def icmp_or_xor_with_sub_3_5_after := [llvm|
{
^0(%arg12 : i64, %arg13 : i64, %arg14 : i64, %arg15 : i64, %arg16 : i64, %arg17 : i64):
  %0 = llvm.icmp "eq" %arg12, %arg13 : i64
  %1 = llvm.icmp "eq" %arg14, %arg15 : i64
  %2 = llvm.and %0, %1 : i1
  %3 = llvm.icmp "eq" %arg16, %arg17 : i64
  %4 = llvm.and %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_or_xor_with_sub_3_5_proof : icmp_or_xor_with_sub_3_5_before ⊑ icmp_or_xor_with_sub_3_5_after := by
  unfold icmp_or_xor_with_sub_3_5_before icmp_or_xor_with_sub_3_5_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_or_xor_with_sub_3_5
  all_goals (try extract_goal ; sorry)
  ---END icmp_or_xor_with_sub_3_5



def icmp_or_xor_with_sub_3_6_before := [llvm|
{
^0(%arg6 : i64, %arg7 : i64, %arg8 : i64, %arg9 : i64, %arg10 : i64, %arg11 : i64):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.sub %arg6, %arg7 : i64
  %2 = llvm.sub %arg8, %arg9 : i64
  %3 = llvm.or %1, %2 : i64
  %4 = llvm.xor %arg10, %arg11 : i64
  %5 = llvm.or %3, %4 : i64
  %6 = llvm.icmp "eq" %5, %0 : i64
  "llvm.return"(%6) : (i1) -> ()
}
]
def icmp_or_xor_with_sub_3_6_after := [llvm|
{
^0(%arg6 : i64, %arg7 : i64, %arg8 : i64, %arg9 : i64, %arg10 : i64, %arg11 : i64):
  %0 = llvm.icmp "eq" %arg6, %arg7 : i64
  %1 = llvm.icmp "eq" %arg8, %arg9 : i64
  %2 = llvm.and %0, %1 : i1
  %3 = llvm.icmp "eq" %arg10, %arg11 : i64
  %4 = llvm.and %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_or_xor_with_sub_3_6_proof : icmp_or_xor_with_sub_3_6_before ⊑ icmp_or_xor_with_sub_3_6_after := by
  unfold icmp_or_xor_with_sub_3_6_before icmp_or_xor_with_sub_3_6_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_or_xor_with_sub_3_6
  all_goals (try extract_goal ; sorry)
  ---END icmp_or_xor_with_sub_3_6



def or_disjoint_with_constants_before := [llvm|
{
^0(%arg5 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(19 : i8) : i8
  %2 = llvm.or %arg5, %0 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def or_disjoint_with_constants_after := [llvm|
{
^0(%arg5 : i8):
  %0 = llvm.mlir.constant(18 : i8) : i8
  %1 = llvm.icmp "eq" %arg5, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_disjoint_with_constants_proof : or_disjoint_with_constants_before ⊑ or_disjoint_with_constants_after := by
  unfold or_disjoint_with_constants_before or_disjoint_with_constants_after
  simp_alive_peephole
  intros
  ---BEGIN or_disjoint_with_constants
  all_goals (try extract_goal ; sorry)
  ---END or_disjoint_with_constants
