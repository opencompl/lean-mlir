
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
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN t0
  all_goals (try extract_goal ; sorry)
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
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN t2
  all_goals (try extract_goal ; sorry)
  ---END t2



def t4_before := [llvm|
{
^0(%arg192 : i8, %arg193 : i1):
  %0 = "llvm.mlir.constant"() <{value = -42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 44 : i8}> : () -> i8
  %2 = "llvm.select"(%arg193, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %3 = llvm.sub %arg192, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def t4_after := [llvm|
{
^0(%arg192 : i8, %arg193 : i1):
  %0 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = -44 : i8}> : () -> i8
  %2 = "llvm.select"(%arg193, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %3 = llvm.add %2, %arg192 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem t4_proof : t4_before ⊑ t4_after := by
  unfold t4_before t4_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN t4
  all_goals (try extract_goal ; sorry)
  ---END t4



def t7_before := [llvm|
{
^0(%arg181 : i8, %arg182 : i1, %arg183 : i8):
  %0 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
  %2 = llvm.shl %0, %arg183 : i8
  %3 = "llvm.select"(%arg182, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %4 = llvm.sub %arg181, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def t7_after := [llvm|
{
^0(%arg181 : i8, %arg182 : i1, %arg183 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
  %2 = llvm.shl %0, %arg183 overflow<nsw> : i8
  %3 = "llvm.select"(%arg182, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %4 = llvm.add %3, %arg181 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
theorem t7_proof : t7_before ⊑ t7_after := by
  unfold t7_before t7_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN t7
  all_goals (try extract_goal ; sorry)
  ---END t7



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
  try simp
  simp_alive_case_bash
  try intros
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
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN neg_of_sub_from_constant
  all_goals (try extract_goal ; sorry)
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
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN sub_from_constant_of_sub_from_constant
  all_goals (try extract_goal ; sorry)
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
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN sub_from_variable_of_sub_from_constant
  all_goals (try extract_goal ; sorry)
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
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN neg_of_add_with_constant
  all_goals (try extract_goal ; sorry)
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
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN sub_from_constant_of_add_with_constant
  all_goals (try extract_goal ; sorry)
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
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN negate_xor
  all_goals (try extract_goal ; sorry)
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
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN negate_shl_xor
  all_goals (try extract_goal ; sorry)
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
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN negate_sdiv
  all_goals (try extract_goal ; sorry)
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
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN negate_ashr
  all_goals (try extract_goal ; sorry)
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
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN negate_lshr
  all_goals (try extract_goal ; sorry)
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
  %4 = llvm.add %arg71, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
theorem negation_of_increment_via_or_with_no_common_bits_set_proof : negation_of_increment_via_or_with_no_common_bits_set_before ⊑ negation_of_increment_via_or_with_no_common_bits_set_after := by
  unfold negation_of_increment_via_or_with_no_common_bits_set_before negation_of_increment_via_or_with_no_common_bits_set_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN negation_of_increment_via_or_with_no_common_bits_set
  all_goals (try extract_goal ; sorry)
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
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN negate_add_with_single_negatible_operand
  all_goals (try extract_goal ; sorry)
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
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN negate_add_with_single_negatible_operand_depth2
  all_goals (try extract_goal ; sorry)
  ---END negate_add_with_single_negatible_operand_depth2


