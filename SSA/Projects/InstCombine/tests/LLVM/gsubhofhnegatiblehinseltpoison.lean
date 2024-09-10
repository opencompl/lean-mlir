import SSA.Projects.InstCombine.tests.LLVM.gsubhofhnegatiblehinseltpoison_proof
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
section gsubhofhnegatiblehinseltpoison_statements
                                                    
def t0_before := [llvm|
{
^0(%arg206 : i8):
  %0 = "llvm.mlir.constant"() <{value = -42 : i8}> : () -> i8
  %1 = llvm.sub %arg206, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def t0_after := [llvm|
{
^0(%arg206 : i8):
  %0 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
  %1 = llvm.add %arg206, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem t0_proof : t0_before ⊑ t0_after := by
  unfold t0_before t0_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN t0
  apply t0_thm
  ---END t0



def t2_before := [llvm|
{
^0(%arg202 : i8, %arg203 : i8):
  %0 = "llvm.mlir.constant"() <{value = -42 : i8}> : () -> i8
  %1 = llvm.shl %0, %arg203 : i8
  %2 = llvm.sub %arg202, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def t2_after := [llvm|
{
^0(%arg202 : i8, %arg203 : i8):
  %0 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
  %1 = llvm.shl %0, %arg203 : i8
  %2 = llvm.add %1, %arg202 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem t2_proof : t2_before ⊑ t2_after := by
  unfold t2_before t2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN t2
  apply t2_thm
  ---END t2



def t9_before := [llvm|
{
^0(%arg176 : i8, %arg177 : i8):
  %0 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
  %1 = llvm.sub %arg177, %arg176 : i8
  %2 = llvm.sub %0, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def t9_after := [llvm|
{
^0(%arg176 : i8, %arg177 : i8):
  %0 = llvm.sub %arg176, %arg177 : i8
  "llvm.return"(%0) : (i8) -> ()
}
]
theorem t9_proof : t9_before ⊑ t9_after := by
  unfold t9_before t9_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN t9
  all_goals (try extract_goal ; sorry)
  ---END t9



def neg_of_sub_from_constant_before := [llvm|
{
^0(%arg172 : i8):
  %0 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
  %2 = llvm.sub %0, %arg172 : i8
  %3 = llvm.sub %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def neg_of_sub_from_constant_after := [llvm|
{
^0(%arg172 : i8):
  %0 = "llvm.mlir.constant"() <{value = -42 : i8}> : () -> i8
  %1 = llvm.add %arg172, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem neg_of_sub_from_constant_proof : neg_of_sub_from_constant_before ⊑ neg_of_sub_from_constant_after := by
  unfold neg_of_sub_from_constant_before neg_of_sub_from_constant_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN neg_of_sub_from_constant
  apply neg_of_sub_from_constant_thm
  ---END neg_of_sub_from_constant



def sub_from_constant_of_sub_from_constant_before := [llvm|
{
^0(%arg170 : i8):
  %0 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 11 : i8}> : () -> i8
  %2 = llvm.sub %0, %arg170 : i8
  %3 = llvm.sub %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def sub_from_constant_of_sub_from_constant_after := [llvm|
{
^0(%arg170 : i8):
  %0 = "llvm.mlir.constant"() <{value = -31 : i8}> : () -> i8
  %1 = llvm.add %arg170, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem sub_from_constant_of_sub_from_constant_proof : sub_from_constant_of_sub_from_constant_before ⊑ sub_from_constant_of_sub_from_constant_after := by
  unfold sub_from_constant_of_sub_from_constant_before sub_from_constant_of_sub_from_constant_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN sub_from_constant_of_sub_from_constant
  apply sub_from_constant_of_sub_from_constant_thm
  ---END sub_from_constant_of_sub_from_constant



def sub_from_variable_of_sub_from_constant_before := [llvm|
{
^0(%arg167 : i8, %arg168 : i8):
  %0 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg167 : i8
  %2 = llvm.sub %arg168, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def sub_from_variable_of_sub_from_constant_after := [llvm|
{
^0(%arg167 : i8, %arg168 : i8):
  %0 = "llvm.mlir.constant"() <{value = -42 : i8}> : () -> i8
  %1 = llvm.add %arg167, %0 : i8
  %2 = llvm.add %1, %arg168 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem sub_from_variable_of_sub_from_constant_proof : sub_from_variable_of_sub_from_constant_before ⊑ sub_from_variable_of_sub_from_constant_after := by
  unfold sub_from_variable_of_sub_from_constant_before sub_from_variable_of_sub_from_constant_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN sub_from_variable_of_sub_from_constant
  apply sub_from_variable_of_sub_from_constant_thm
  ---END sub_from_variable_of_sub_from_constant



def neg_of_add_with_constant_before := [llvm|
{
^0(%arg155 : i8):
  %0 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
  %2 = llvm.add %arg155, %0 : i8
  %3 = llvm.sub %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def neg_of_add_with_constant_after := [llvm|
{
^0(%arg155 : i8):
  %0 = "llvm.mlir.constant"() <{value = -42 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg155 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem neg_of_add_with_constant_proof : neg_of_add_with_constant_before ⊑ neg_of_add_with_constant_after := by
  unfold neg_of_add_with_constant_before neg_of_add_with_constant_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN neg_of_add_with_constant
  apply neg_of_add_with_constant_thm
  ---END neg_of_add_with_constant



def sub_from_constant_of_add_with_constant_before := [llvm|
{
^0(%arg153 : i8):
  %0 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 11 : i8}> : () -> i8
  %2 = llvm.add %arg153, %0 : i8
  %3 = llvm.sub %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def sub_from_constant_of_add_with_constant_after := [llvm|
{
^0(%arg153 : i8):
  %0 = "llvm.mlir.constant"() <{value = -31 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg153 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem sub_from_constant_of_add_with_constant_proof : sub_from_constant_of_add_with_constant_before ⊑ sub_from_constant_of_add_with_constant_after := by
  unfold sub_from_constant_of_add_with_constant_before sub_from_constant_of_add_with_constant_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN sub_from_constant_of_add_with_constant
  apply sub_from_constant_of_add_with_constant_thm
  ---END sub_from_constant_of_add_with_constant



def negate_xor_before := [llvm|
{
^0(%arg126 : i4):
  %0 = "llvm.mlir.constant"() <{value = 5 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{value = 0 : i4}> : () -> i4
  %2 = llvm.xor %arg126, %0 : i4
  %3 = llvm.sub %1, %2 : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
def negate_xor_after := [llvm|
{
^0(%arg126 : i4):
  %0 = "llvm.mlir.constant"() <{value = -6 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{value = 1 : i4}> : () -> i4
  %2 = llvm.xor %arg126, %0 : i4
  %3 = llvm.add %2, %1 : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
theorem negate_xor_proof : negate_xor_before ⊑ negate_xor_after := by
  unfold negate_xor_before negate_xor_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN negate_xor
  apply negate_xor_thm
  ---END negate_xor



def negate_shl_xor_before := [llvm|
{
^0(%arg122 : i4, %arg123 : i4):
  %0 = "llvm.mlir.constant"() <{value = 5 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{value = 0 : i4}> : () -> i4
  %2 = llvm.xor %arg122, %0 : i4
  %3 = llvm.shl %2, %arg123 : i4
  %4 = llvm.sub %1, %3 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def negate_shl_xor_after := [llvm|
{
^0(%arg122 : i4, %arg123 : i4):
  %0 = "llvm.mlir.constant"() <{value = -6 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{value = 1 : i4}> : () -> i4
  %2 = llvm.xor %arg122, %0 : i4
  %3 = llvm.add %2, %1 : i4
  %4 = llvm.shl %3, %arg123 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
theorem negate_shl_xor_proof : negate_shl_xor_before ⊑ negate_shl_xor_after := by
  unfold negate_shl_xor_before negate_shl_xor_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN negate_shl_xor
  apply negate_shl_xor_thm
  ---END negate_shl_xor



def negate_sdiv_before := [llvm|
{
^0(%arg116 : i8, %arg117 : i8):
  %0 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
  %1 = llvm.sdiv %arg117, %0 : i8
  %2 = llvm.sub %arg116, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def negate_sdiv_after := [llvm|
{
^0(%arg116 : i8, %arg117 : i8):
  %0 = "llvm.mlir.constant"() <{value = -42 : i8}> : () -> i8
  %1 = llvm.sdiv %arg117, %0 : i8
  %2 = llvm.add %1, %arg116 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem negate_sdiv_proof : negate_sdiv_before ⊑ negate_sdiv_after := by
  unfold negate_sdiv_before negate_sdiv_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN negate_sdiv
  apply negate_sdiv_thm
  ---END negate_sdiv



def negate_ashr_before := [llvm|
{
^0(%arg110 : i8, %arg111 : i8):
  %0 = "llvm.mlir.constant"() <{value = 7 : i8}> : () -> i8
  %1 = llvm.ashr %arg111, %0 : i8
  %2 = llvm.sub %arg110, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def negate_ashr_after := [llvm|
{
^0(%arg110 : i8, %arg111 : i8):
  %0 = "llvm.mlir.constant"() <{value = 7 : i8}> : () -> i8
  %1 = llvm.lshr %arg111, %0 : i8
  %2 = llvm.add %1, %arg110 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem negate_ashr_proof : negate_ashr_before ⊑ negate_ashr_after := by
  unfold negate_ashr_before negate_ashr_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN negate_ashr
  apply negate_ashr_thm
  ---END negate_ashr



def negate_lshr_before := [llvm|
{
^0(%arg108 : i8, %arg109 : i8):
  %0 = "llvm.mlir.constant"() <{value = 7 : i8}> : () -> i8
  %1 = llvm.lshr %arg109, %0 : i8
  %2 = llvm.sub %arg108, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def negate_lshr_after := [llvm|
{
^0(%arg108 : i8, %arg109 : i8):
  %0 = "llvm.mlir.constant"() <{value = 7 : i8}> : () -> i8
  %1 = llvm.ashr %arg109, %0 : i8
  %2 = llvm.add %1, %arg108 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem negate_lshr_proof : negate_lshr_before ⊑ negate_lshr_after := by
  unfold negate_lshr_before negate_lshr_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN negate_lshr
  apply negate_lshr_thm
  ---END negate_lshr



def negation_of_increment_via_or_with_no_common_bits_set_before := [llvm|
{
^0(%arg71 : i8, %arg72 : i8):
  %0 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %1 = llvm.shl %arg72, %0 : i8
  %2 = llvm.or %1, %0 : i8
  %3 = llvm.sub %arg71, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def negation_of_increment_via_or_with_no_common_bits_set_after := [llvm|
{
^0(%arg71 : i8, %arg72 : i8):
  %0 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %2 = llvm.shl %arg72, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  %4 = llvm.add %3, %arg71 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
theorem negation_of_increment_via_or_with_no_common_bits_set_proof : negation_of_increment_via_or_with_no_common_bits_set_before ⊑ negation_of_increment_via_or_with_no_common_bits_set_after := by
  unfold negation_of_increment_via_or_with_no_common_bits_set_before negation_of_increment_via_or_with_no_common_bits_set_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN negation_of_increment_via_or_with_no_common_bits_set
  apply negation_of_increment_via_or_with_no_common_bits_set_thm
  ---END negation_of_increment_via_or_with_no_common_bits_set



def negate_add_with_single_negatible_operand_before := [llvm|
{
^0(%arg23 : i8, %arg24 : i8):
  %0 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
  %2 = llvm.add %arg23, %0 : i8
  %3 = llvm.sub %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def negate_add_with_single_negatible_operand_after := [llvm|
{
^0(%arg23 : i8, %arg24 : i8):
  %0 = "llvm.mlir.constant"() <{value = -42 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg23 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem negate_add_with_single_negatible_operand_proof : negate_add_with_single_negatible_operand_before ⊑ negate_add_with_single_negatible_operand_after := by
  unfold negate_add_with_single_negatible_operand_before negate_add_with_single_negatible_operand_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN negate_add_with_single_negatible_operand
  apply negate_add_with_single_negatible_operand_thm
  ---END negate_add_with_single_negatible_operand



def negate_add_with_single_negatible_operand_depth2_before := [llvm|
{
^0(%arg21 : i8, %arg22 : i8):
  %0 = "llvm.mlir.constant"() <{value = 21 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
  %2 = llvm.add %arg21, %0 : i8
  %3 = llvm.mul %2, %arg22 : i8
  %4 = llvm.sub %1, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def negate_add_with_single_negatible_operand_depth2_after := [llvm|
{
^0(%arg21 : i8, %arg22 : i8):
  %0 = "llvm.mlir.constant"() <{value = -21 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg21 : i8
  %2 = llvm.mul %1, %arg22 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem negate_add_with_single_negatible_operand_depth2_proof : negate_add_with_single_negatible_operand_depth2_before ⊑ negate_add_with_single_negatible_operand_depth2_after := by
  unfold negate_add_with_single_negatible_operand_depth2_before negate_add_with_single_negatible_operand_depth2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN negate_add_with_single_negatible_operand_depth2
  apply negate_add_with_single_negatible_operand_depth2_thm
  ---END negate_add_with_single_negatible_operand_depth2


