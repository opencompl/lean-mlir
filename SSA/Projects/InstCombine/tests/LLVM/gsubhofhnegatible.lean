
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
section gsubhofhnegatible_statements

def t0_before := [llvm|
{
^0(%arg214 : i8):
  %0 = "llvm.mlir.constant"() <{value = -42 : i8}> : () -> i8
  %1 = llvm.sub %arg214, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def t0_after := [llvm|
{
^0(%arg214 : i8):
  %0 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
  %1 = llvm.add %arg214, %0 : i8
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
^0(%arg210 : i8, %arg211 : i8):
  %0 = "llvm.mlir.constant"() <{value = -42 : i8}> : () -> i8
  %1 = llvm.shl %0, %arg211 : i8
  %2 = llvm.sub %arg210, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def t2_after := [llvm|
{
^0(%arg210 : i8, %arg211 : i8):
  %0 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
  %1 = llvm.shl %0, %arg211 : i8
  %2 = llvm.add %1, %arg210 : i8
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



<<<<<<< HEAD
def t4_before := [llvm|
{
^0(%arg200 : i8, %arg201 : i1):
  %0 = "llvm.mlir.constant"() <{value = -42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 44 : i8}> : () -> i8
  %2 = "llvm.select"(%arg201, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %3 = llvm.sub %arg200, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def t4_after := [llvm|
{
^0(%arg200 : i8, %arg201 : i1):
  %0 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = -44 : i8}> : () -> i8
  %2 = "llvm.select"(%arg201, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %3 = llvm.add %2, %arg200 : i8
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



def PR52261_before := [llvm|
{
^0(%arg198 : i1):
  %0 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -2 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
  %3 = "llvm.select"(%arg198, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.sub %2, %3 overflow<nsw> : i32
  %5 = llvm.and %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def PR52261_after := [llvm|
{
^0(%arg198 : i1):
  %0 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem PR52261_proof : PR52261_before ⊑ PR52261_after := by
  unfold PR52261_before PR52261_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN PR52261
  all_goals (try extract_goal ; sorry)
  ---END PR52261



def t7_before := [llvm|
{
^0(%arg187 : i8, %arg188 : i1, %arg189 : i8):
  %0 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
  %2 = llvm.shl %0, %arg189 : i8
  %3 = "llvm.select"(%arg188, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %4 = llvm.sub %arg187, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def t7_after := [llvm|
{
^0(%arg187 : i8, %arg188 : i1, %arg189 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
  %2 = llvm.shl %0, %arg189 overflow<nsw> : i8
  %3 = "llvm.select"(%arg188, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %4 = llvm.add %3, %arg187 : i8
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



=======
>>>>>>> 4bf2f937 (Re-ran the sccripts)
def t9_before := [llvm|
{
^0(%arg182 : i8, %arg183 : i8):
  %0 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
  %1 = llvm.sub %arg183, %arg182 : i8
  %2 = llvm.sub %0, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def t9_after := [llvm|
{
^0(%arg182 : i8, %arg183 : i8):
  %0 = llvm.sub %arg182, %arg183 : i8
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
^0(%arg178 : i8):
  %0 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
  %2 = llvm.sub %0, %arg178 : i8
  %3 = llvm.sub %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def neg_of_sub_from_constant_after := [llvm|
{
^0(%arg178 : i8):
  %0 = "llvm.mlir.constant"() <{value = -42 : i8}> : () -> i8
  %1 = llvm.add %arg178, %0 : i8
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
^0(%arg176 : i8):
  %0 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 11 : i8}> : () -> i8
  %2 = llvm.sub %0, %arg176 : i8
  %3 = llvm.sub %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def sub_from_constant_of_sub_from_constant_after := [llvm|
{
^0(%arg176 : i8):
  %0 = "llvm.mlir.constant"() <{value = -31 : i8}> : () -> i8
  %1 = llvm.add %arg176, %0 : i8
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
^0(%arg173 : i8, %arg174 : i8):
  %0 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg173 : i8
  %2 = llvm.sub %arg174, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def sub_from_variable_of_sub_from_constant_after := [llvm|
{
^0(%arg173 : i8, %arg174 : i8):
  %0 = "llvm.mlir.constant"() <{value = -42 : i8}> : () -> i8
  %1 = llvm.add %arg173, %0 : i8
  %2 = llvm.add %1, %arg174 : i8
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
^0(%arg161 : i8):
  %0 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
  %2 = llvm.add %arg161, %0 : i8
  %3 = llvm.sub %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def neg_of_add_with_constant_after := [llvm|
{
^0(%arg161 : i8):
  %0 = "llvm.mlir.constant"() <{value = -42 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg161 : i8
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
^0(%arg159 : i8):
  %0 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 11 : i8}> : () -> i8
  %2 = llvm.add %arg159, %0 : i8
  %3 = llvm.sub %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def sub_from_constant_of_add_with_constant_after := [llvm|
{
^0(%arg159 : i8):
  %0 = "llvm.mlir.constant"() <{value = -31 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg159 : i8
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
^0(%arg132 : i4):
  %0 = "llvm.mlir.constant"() <{value = 5 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{value = 0 : i4}> : () -> i4
  %2 = llvm.xor %arg132, %0 : i4
  %3 = llvm.sub %1, %2 : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
def negate_xor_after := [llvm|
{
^0(%arg132 : i4):
  %0 = "llvm.mlir.constant"() <{value = -6 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{value = 1 : i4}> : () -> i4
  %2 = llvm.xor %arg132, %0 : i4
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
^0(%arg128 : i4, %arg129 : i4):
  %0 = "llvm.mlir.constant"() <{value = 5 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{value = 0 : i4}> : () -> i4
  %2 = llvm.xor %arg128, %0 : i4
  %3 = llvm.shl %2, %arg129 : i4
  %4 = llvm.sub %1, %3 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def negate_shl_xor_after := [llvm|
{
^0(%arg128 : i4, %arg129 : i4):
  %0 = "llvm.mlir.constant"() <{value = -6 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{value = 1 : i4}> : () -> i4
  %2 = llvm.xor %arg128, %0 : i4
  %3 = llvm.add %2, %1 : i4
  %4 = llvm.shl %3, %arg129 : i4
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
^0(%arg122 : i8, %arg123 : i8):
  %0 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
  %1 = llvm.sdiv %arg123, %0 : i8
  %2 = llvm.sub %arg122, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def negate_sdiv_after := [llvm|
{
^0(%arg122 : i8, %arg123 : i8):
  %0 = "llvm.mlir.constant"() <{value = -42 : i8}> : () -> i8
  %1 = llvm.sdiv %arg123, %0 : i8
  %2 = llvm.add %1, %arg122 : i8
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
^0(%arg116 : i8, %arg117 : i8):
  %0 = "llvm.mlir.constant"() <{value = 7 : i8}> : () -> i8
  %1 = llvm.ashr %arg117, %0 : i8
  %2 = llvm.sub %arg116, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def negate_ashr_after := [llvm|
{
^0(%arg116 : i8, %arg117 : i8):
  %0 = "llvm.mlir.constant"() <{value = 7 : i8}> : () -> i8
  %1 = llvm.lshr %arg117, %0 : i8
  %2 = llvm.add %1, %arg116 : i8
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
^0(%arg114 : i8, %arg115 : i8):
  %0 = "llvm.mlir.constant"() <{value = 7 : i8}> : () -> i8
  %1 = llvm.lshr %arg115, %0 : i8
  %2 = llvm.sub %arg114, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def negate_lshr_after := [llvm|
{
^0(%arg114 : i8, %arg115 : i8):
  %0 = "llvm.mlir.constant"() <{value = 7 : i8}> : () -> i8
  %1 = llvm.ashr %arg115, %0 : i8
  %2 = llvm.add %1, %arg114 : i8
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
^0(%arg77 : i8, %arg78 : i8):
  %0 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %1 = llvm.shl %arg78, %0 : i8
  %2 = llvm.or %1, %0 : i8
  %3 = llvm.sub %arg77, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def negation_of_increment_via_or_with_no_common_bits_set_after := [llvm|
{
^0(%arg77 : i8, %arg78 : i8):
  %0 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %2 = llvm.shl %arg78, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  %4 = llvm.add %arg77, %3 : i8
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



def negation_of_increment_via_or_disjoint_before := [llvm|
{
^0(%arg71 : i8, %arg72 : i8):
  %0 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %1 = llvm.or %arg72, %0 : i8
  %2 = llvm.sub %arg71, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def negation_of_increment_via_or_disjoint_after := [llvm|
{
^0(%arg71 : i8, %arg72 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = llvm.xor %arg72, %0 : i8
  %2 = llvm.add %arg71, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem negation_of_increment_via_or_disjoint_proof : negation_of_increment_via_or_disjoint_before ⊑ negation_of_increment_via_or_disjoint_after := by
  unfold negation_of_increment_via_or_disjoint_before negation_of_increment_via_or_disjoint_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN negation_of_increment_via_or_disjoint
  all_goals (try extract_goal ; sorry)
  ---END negation_of_increment_via_or_disjoint



def negate_add_with_single_negatible_operand_before := [llvm|
{
^0(%arg27 : i8, %arg28 : i8):
  %0 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
  %2 = llvm.add %arg27, %0 : i8
  %3 = llvm.sub %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def negate_add_with_single_negatible_operand_after := [llvm|
{
^0(%arg27 : i8, %arg28 : i8):
  %0 = "llvm.mlir.constant"() <{value = -42 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg27 : i8
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
^0(%arg25 : i8, %arg26 : i8):
  %0 = "llvm.mlir.constant"() <{value = 21 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
  %2 = llvm.add %arg25, %0 : i8
  %3 = llvm.mul %2, %arg26 : i8
  %4 = llvm.sub %1, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def negate_add_with_single_negatible_operand_depth2_after := [llvm|
{
^0(%arg25 : i8, %arg26 : i8):
  %0 = "llvm.mlir.constant"() <{value = -21 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg25 : i8
  %2 = llvm.mul %1, %arg26 : i8
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


