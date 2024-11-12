
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
^0(%arg224 : i8):
  %0 = llvm.mlir.constant(-42 : i8) : i8
  %1 = llvm.sub %arg224, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def t0_after := [llvm|
{
^0(%arg224 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.add %arg224, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t0_proof : t0_before ⊑ t0_after := by
  unfold t0_before t0_after
  simp_alive_peephole
  intros
  ---BEGIN t0
  all_goals (try extract_goal ; sorry)
  ---END t0



def t2_before := [llvm|
{
^0(%arg220 : i8, %arg221 : i8):
  %0 = llvm.mlir.constant(-42 : i8) : i8
  %1 = llvm.shl %0, %arg221 : i8
  %2 = llvm.sub %arg220, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def t2_after := [llvm|
{
^0(%arg220 : i8, %arg221 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.shl %0, %arg221 : i8
  %2 = llvm.add %1, %arg220 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t2_proof : t2_before ⊑ t2_after := by
  unfold t2_before t2_after
  simp_alive_peephole
  intros
  ---BEGIN t2
  all_goals (try extract_goal ; sorry)
  ---END t2



def t4_before := [llvm|
{
^0(%arg210 : i8, %arg211 : i1):
  %0 = llvm.mlir.constant(-42 : i8) : i8
  %1 = llvm.mlir.constant(44 : i8) : i8
  %2 = "llvm.select"(%arg211, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %3 = llvm.sub %arg210, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def t4_after := [llvm|
{
^0(%arg210 : i8, %arg211 : i1):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(-44 : i8) : i8
  %2 = "llvm.select"(%arg211, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %3 = llvm.add %2, %arg210 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t4_proof : t4_before ⊑ t4_after := by
  unfold t4_before t4_after
  simp_alive_peephole
  intros
  ---BEGIN t4
  all_goals (try extract_goal ; sorry)
  ---END t4



def PR52261_before := [llvm|
{
^0(%arg208 : i1):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(-2 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = "llvm.select"(%arg208, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.sub %2, %3 overflow<nsw> : i32
  %5 = llvm.and %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def PR52261_after := [llvm|
{
^0(%arg208 : i1):
  %0 = llvm.mlir.constant(2 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR52261_proof : PR52261_before ⊑ PR52261_after := by
  unfold PR52261_before PR52261_after
  simp_alive_peephole
  intros
  ---BEGIN PR52261
  all_goals (try extract_goal ; sorry)
  ---END PR52261



def t7_before := [llvm|
{
^0(%arg197 : i8, %arg198 : i1, %arg199 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.shl %0, %arg199 : i8
  %3 = "llvm.select"(%arg198, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %4 = llvm.sub %arg197, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def t7_after := [llvm|
{
^0(%arg197 : i8, %arg198 : i1, %arg199 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.shl %0, %arg199 overflow<nsw> : i8
  %3 = "llvm.select"(%arg198, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %4 = llvm.add %3, %arg197 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t7_proof : t7_before ⊑ t7_after := by
  unfold t7_before t7_after
  simp_alive_peephole
  intros
  ---BEGIN t7
  all_goals (try extract_goal ; sorry)
  ---END t7



def t9_before := [llvm|
{
^0(%arg192 : i8, %arg193 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.sub %arg193, %arg192 : i8
  %2 = llvm.sub %0, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def t9_after := [llvm|
{
^0(%arg192 : i8, %arg193 : i8):
  %0 = llvm.sub %arg192, %arg193 : i8
  "llvm.return"(%0) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t9_proof : t9_before ⊑ t9_after := by
  unfold t9_before t9_after
  simp_alive_peephole
  intros
  ---BEGIN t9
  all_goals (try extract_goal ; sorry)
  ---END t9



def neg_of_sub_from_constant_before := [llvm|
{
^0(%arg188 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.sub %0, %arg188 : i8
  %3 = llvm.sub %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def neg_of_sub_from_constant_after := [llvm|
{
^0(%arg188 : i8):
  %0 = llvm.mlir.constant(-42 : i8) : i8
  %1 = llvm.add %arg188, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem neg_of_sub_from_constant_proof : neg_of_sub_from_constant_before ⊑ neg_of_sub_from_constant_after := by
  unfold neg_of_sub_from_constant_before neg_of_sub_from_constant_after
  simp_alive_peephole
  intros
  ---BEGIN neg_of_sub_from_constant
  all_goals (try extract_goal ; sorry)
  ---END neg_of_sub_from_constant



def sub_from_constant_of_sub_from_constant_before := [llvm|
{
^0(%arg186 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(11 : i8) : i8
  %2 = llvm.sub %0, %arg186 : i8
  %3 = llvm.sub %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def sub_from_constant_of_sub_from_constant_after := [llvm|
{
^0(%arg186 : i8):
  %0 = llvm.mlir.constant(-31 : i8) : i8
  %1 = llvm.add %arg186, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sub_from_constant_of_sub_from_constant_proof : sub_from_constant_of_sub_from_constant_before ⊑ sub_from_constant_of_sub_from_constant_after := by
  unfold sub_from_constant_of_sub_from_constant_before sub_from_constant_of_sub_from_constant_after
  simp_alive_peephole
  intros
  ---BEGIN sub_from_constant_of_sub_from_constant
  all_goals (try extract_goal ; sorry)
  ---END sub_from_constant_of_sub_from_constant



def sub_from_variable_of_sub_from_constant_before := [llvm|
{
^0(%arg183 : i8, %arg184 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.sub %0, %arg183 : i8
  %2 = llvm.sub %arg184, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def sub_from_variable_of_sub_from_constant_after := [llvm|
{
^0(%arg183 : i8, %arg184 : i8):
  %0 = llvm.mlir.constant(-42 : i8) : i8
  %1 = llvm.add %arg183, %0 : i8
  %2 = llvm.add %1, %arg184 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sub_from_variable_of_sub_from_constant_proof : sub_from_variable_of_sub_from_constant_before ⊑ sub_from_variable_of_sub_from_constant_after := by
  unfold sub_from_variable_of_sub_from_constant_before sub_from_variable_of_sub_from_constant_after
  simp_alive_peephole
  intros
  ---BEGIN sub_from_variable_of_sub_from_constant
  all_goals (try extract_goal ; sorry)
  ---END sub_from_variable_of_sub_from_constant



def neg_of_add_with_constant_before := [llvm|
{
^0(%arg171 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.add %arg171, %0 : i8
  %3 = llvm.sub %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def neg_of_add_with_constant_after := [llvm|
{
^0(%arg171 : i8):
  %0 = llvm.mlir.constant(-42 : i8) : i8
  %1 = llvm.sub %0, %arg171 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem neg_of_add_with_constant_proof : neg_of_add_with_constant_before ⊑ neg_of_add_with_constant_after := by
  unfold neg_of_add_with_constant_before neg_of_add_with_constant_after
  simp_alive_peephole
  intros
  ---BEGIN neg_of_add_with_constant
  all_goals (try extract_goal ; sorry)
  ---END neg_of_add_with_constant



def sub_from_constant_of_add_with_constant_before := [llvm|
{
^0(%arg169 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(11 : i8) : i8
  %2 = llvm.add %arg169, %0 : i8
  %3 = llvm.sub %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def sub_from_constant_of_add_with_constant_after := [llvm|
{
^0(%arg169 : i8):
  %0 = llvm.mlir.constant(-31 : i8) : i8
  %1 = llvm.sub %0, %arg169 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sub_from_constant_of_add_with_constant_proof : sub_from_constant_of_add_with_constant_before ⊑ sub_from_constant_of_add_with_constant_after := by
  unfold sub_from_constant_of_add_with_constant_before sub_from_constant_of_add_with_constant_after
  simp_alive_peephole
  intros
  ---BEGIN sub_from_constant_of_add_with_constant
  all_goals (try extract_goal ; sorry)
  ---END sub_from_constant_of_add_with_constant



def t20_before := [llvm|
{
^0(%arg145 : i8, %arg146 : i16):
  %0 = llvm.mlir.constant(-42 : i16) : i16
  %1 = llvm.shl %0, %arg146 : i16
  %2 = llvm.trunc %1 : i16 to i8
  %3 = llvm.sub %arg145, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def t20_after := [llvm|
{
^0(%arg145 : i8, %arg146 : i16):
  %0 = llvm.mlir.constant(42 : i16) : i16
  %1 = llvm.shl %0, %arg146 : i16
  %2 = llvm.trunc %1 : i16 to i8
  %3 = llvm.add %arg145, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t20_proof : t20_before ⊑ t20_after := by
  unfold t20_before t20_after
  simp_alive_peephole
  intros
  ---BEGIN t20
  all_goals (try extract_goal ; sorry)
  ---END t20



def negate_xor_before := [llvm|
{
^0(%arg142 : i4):
  %0 = llvm.mlir.constant(5 : i4) : i4
  %1 = llvm.mlir.constant(0 : i4) : i4
  %2 = llvm.xor %arg142, %0 : i4
  %3 = llvm.sub %1, %2 : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
def negate_xor_after := [llvm|
{
^0(%arg142 : i4):
  %0 = llvm.mlir.constant(-6 : i4) : i4
  %1 = llvm.mlir.constant(1 : i4) : i4
  %2 = llvm.xor %arg142, %0 : i4
  %3 = llvm.add %2, %1 : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
set_option debug.skipKernelTC true in
theorem negate_xor_proof : negate_xor_before ⊑ negate_xor_after := by
  unfold negate_xor_before negate_xor_after
  simp_alive_peephole
  intros
  ---BEGIN negate_xor
  all_goals (try extract_goal ; sorry)
  ---END negate_xor



def negate_shl_xor_before := [llvm|
{
^0(%arg138 : i4, %arg139 : i4):
  %0 = llvm.mlir.constant(5 : i4) : i4
  %1 = llvm.mlir.constant(0 : i4) : i4
  %2 = llvm.xor %arg138, %0 : i4
  %3 = llvm.shl %2, %arg139 : i4
  %4 = llvm.sub %1, %3 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def negate_shl_xor_after := [llvm|
{
^0(%arg138 : i4, %arg139 : i4):
  %0 = llvm.mlir.constant(-6 : i4) : i4
  %1 = llvm.mlir.constant(1 : i4) : i4
  %2 = llvm.xor %arg138, %0 : i4
  %3 = llvm.add %2, %1 : i4
  %4 = llvm.shl %3, %arg139 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
set_option debug.skipKernelTC true in
theorem negate_shl_xor_proof : negate_shl_xor_before ⊑ negate_shl_xor_after := by
  unfold negate_shl_xor_before negate_shl_xor_after
  simp_alive_peephole
  intros
  ---BEGIN negate_shl_xor
  all_goals (try extract_goal ; sorry)
  ---END negate_shl_xor



def negate_sdiv_before := [llvm|
{
^0(%arg132 : i8, %arg133 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.sdiv %arg133, %0 : i8
  %2 = llvm.sub %arg132, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def negate_sdiv_after := [llvm|
{
^0(%arg132 : i8, %arg133 : i8):
  %0 = llvm.mlir.constant(-42 : i8) : i8
  %1 = llvm.sdiv %arg133, %0 : i8
  %2 = llvm.add %1, %arg132 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem negate_sdiv_proof : negate_sdiv_before ⊑ negate_sdiv_after := by
  unfold negate_sdiv_before negate_sdiv_after
  simp_alive_peephole
  intros
  ---BEGIN negate_sdiv
  all_goals (try extract_goal ; sorry)
  ---END negate_sdiv



def negate_ashr_before := [llvm|
{
^0(%arg126 : i8, %arg127 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.ashr %arg127, %0 : i8
  %2 = llvm.sub %arg126, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def negate_ashr_after := [llvm|
{
^0(%arg126 : i8, %arg127 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.lshr %arg127, %0 : i8
  %2 = llvm.add %1, %arg126 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem negate_ashr_proof : negate_ashr_before ⊑ negate_ashr_after := by
  unfold negate_ashr_before negate_ashr_after
  simp_alive_peephole
  intros
  ---BEGIN negate_ashr
  all_goals (try extract_goal ; sorry)
  ---END negate_ashr



def negate_lshr_before := [llvm|
{
^0(%arg124 : i8, %arg125 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.lshr %arg125, %0 : i8
  %2 = llvm.sub %arg124, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def negate_lshr_after := [llvm|
{
^0(%arg124 : i8, %arg125 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.ashr %arg125, %0 : i8
  %2 = llvm.add %1, %arg124 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem negate_lshr_proof : negate_lshr_before ⊑ negate_lshr_after := by
  unfold negate_lshr_before negate_lshr_after
  simp_alive_peephole
  intros
  ---BEGIN negate_lshr
  all_goals (try extract_goal ; sorry)
  ---END negate_lshr



def negate_sext_before := [llvm|
{
^0(%arg114 : i8, %arg115 : i1):
  %0 = llvm.sext %arg115 : i1 to i8
  %1 = llvm.sub %arg114, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def negate_sext_after := [llvm|
{
^0(%arg114 : i8, %arg115 : i1):
  %0 = llvm.zext %arg115 : i1 to i8
  %1 = llvm.add %arg114, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem negate_sext_proof : negate_sext_before ⊑ negate_sext_after := by
  unfold negate_sext_before negate_sext_after
  simp_alive_peephole
  intros
  ---BEGIN negate_sext
  all_goals (try extract_goal ; sorry)
  ---END negate_sext



def negate_zext_before := [llvm|
{
^0(%arg112 : i8, %arg113 : i1):
  %0 = llvm.zext %arg113 : i1 to i8
  %1 = llvm.sub %arg112, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def negate_zext_after := [llvm|
{
^0(%arg112 : i8, %arg113 : i1):
  %0 = llvm.sext %arg113 : i1 to i8
  %1 = llvm.add %arg112, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem negate_zext_proof : negate_zext_before ⊑ negate_zext_after := by
  unfold negate_zext_before negate_zext_after
  simp_alive_peephole
  intros
  ---BEGIN negate_zext
  all_goals (try extract_goal ; sorry)
  ---END negate_zext



def negation_of_increment_via_or_with_no_common_bits_set_before := [llvm|
{
^0(%arg87 : i8, %arg88 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.shl %arg88, %0 : i8
  %2 = llvm.or %1, %0 : i8
  %3 = llvm.sub %arg87, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def negation_of_increment_via_or_with_no_common_bits_set_after := [llvm|
{
^0(%arg87 : i8, %arg88 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.shl %arg88, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  %4 = llvm.add %arg87, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem negation_of_increment_via_or_with_no_common_bits_set_proof : negation_of_increment_via_or_with_no_common_bits_set_before ⊑ negation_of_increment_via_or_with_no_common_bits_set_after := by
  unfold negation_of_increment_via_or_with_no_common_bits_set_before negation_of_increment_via_or_with_no_common_bits_set_after
  simp_alive_peephole
  intros
  ---BEGIN negation_of_increment_via_or_with_no_common_bits_set
  all_goals (try extract_goal ; sorry)
  ---END negation_of_increment_via_or_with_no_common_bits_set



def negation_of_increment_via_or_disjoint_before := [llvm|
{
^0(%arg81 : i8, %arg82 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.or disjoint %arg82, %0 : i8
  %2 = llvm.sub %arg81, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def negation_of_increment_via_or_disjoint_after := [llvm|
{
^0(%arg81 : i8, %arg82 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.xor %arg82, %0 : i8
  %2 = llvm.add %arg81, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem negation_of_increment_via_or_disjoint_proof : negation_of_increment_via_or_disjoint_before ⊑ negation_of_increment_via_or_disjoint_after := by
  unfold negation_of_increment_via_or_disjoint_before negation_of_increment_via_or_disjoint_after
  simp_alive_peephole
  intros
  ---BEGIN negation_of_increment_via_or_disjoint
  all_goals (try extract_goal ; sorry)
  ---END negation_of_increment_via_or_disjoint



def negate_add_with_single_negatible_operand_before := [llvm|
{
^0(%arg37 : i8, %arg38 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.add %arg37, %0 : i8
  %3 = llvm.sub %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def negate_add_with_single_negatible_operand_after := [llvm|
{
^0(%arg37 : i8, %arg38 : i8):
  %0 = llvm.mlir.constant(-42 : i8) : i8
  %1 = llvm.sub %0, %arg37 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem negate_add_with_single_negatible_operand_proof : negate_add_with_single_negatible_operand_before ⊑ negate_add_with_single_negatible_operand_after := by
  unfold negate_add_with_single_negatible_operand_before negate_add_with_single_negatible_operand_after
  simp_alive_peephole
  intros
  ---BEGIN negate_add_with_single_negatible_operand
  all_goals (try extract_goal ; sorry)
  ---END negate_add_with_single_negatible_operand



def negate_add_with_single_negatible_operand_depth2_before := [llvm|
{
^0(%arg35 : i8, %arg36 : i8):
  %0 = llvm.mlir.constant(21 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.add %arg35, %0 : i8
  %3 = llvm.mul %2, %arg36 : i8
  %4 = llvm.sub %1, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def negate_add_with_single_negatible_operand_depth2_after := [llvm|
{
^0(%arg35 : i8, %arg36 : i8):
  %0 = llvm.mlir.constant(-21 : i8) : i8
  %1 = llvm.sub %0, %arg35 : i8
  %2 = llvm.mul %1, %arg36 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem negate_add_with_single_negatible_operand_depth2_proof : negate_add_with_single_negatible_operand_depth2_before ⊑ negate_add_with_single_negatible_operand_depth2_after := by
  unfold negate_add_with_single_negatible_operand_depth2_before negate_add_with_single_negatible_operand_depth2_after
  simp_alive_peephole
  intros
  ---BEGIN negate_add_with_single_negatible_operand_depth2
  all_goals (try extract_goal ; sorry)
  ---END negate_add_with_single_negatible_operand_depth2



def negate_select_of_op_vs_negated_op_nsw_before := [llvm|
{
^0(%arg21 : i8, %arg22 : i8, %arg23 : i1):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.sub %0, %arg21 overflow<nsw> : i8
  %2 = "llvm.select"(%arg23, %1, %arg21) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %3 = llvm.sub %arg22, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def negate_select_of_op_vs_negated_op_nsw_after := [llvm|
{
^0(%arg21 : i8, %arg22 : i8, %arg23 : i1):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.sub %0, %arg21 : i8
  %2 = "llvm.select"(%arg23, %arg21, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %3 = llvm.add %2, %arg22 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem negate_select_of_op_vs_negated_op_nsw_proof : negate_select_of_op_vs_negated_op_nsw_before ⊑ negate_select_of_op_vs_negated_op_nsw_after := by
  unfold negate_select_of_op_vs_negated_op_nsw_before negate_select_of_op_vs_negated_op_nsw_after
  simp_alive_peephole
  intros
  ---BEGIN negate_select_of_op_vs_negated_op_nsw
  all_goals (try extract_goal ; sorry)
  ---END negate_select_of_op_vs_negated_op_nsw



def negate_select_of_op_vs_negated_op_nsw_commuted_before := [llvm|
{
^0(%arg18 : i8, %arg19 : i8, %arg20 : i1):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.sub %0, %arg18 overflow<nsw> : i8
  %2 = "llvm.select"(%arg20, %arg18, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %3 = llvm.sub %arg19, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def negate_select_of_op_vs_negated_op_nsw_commuted_after := [llvm|
{
^0(%arg18 : i8, %arg19 : i8, %arg20 : i1):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.sub %0, %arg18 : i8
  %2 = "llvm.select"(%arg20, %1, %arg18) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %3 = llvm.add %2, %arg19 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem negate_select_of_op_vs_negated_op_nsw_commuted_proof : negate_select_of_op_vs_negated_op_nsw_commuted_before ⊑ negate_select_of_op_vs_negated_op_nsw_commuted_after := by
  unfold negate_select_of_op_vs_negated_op_nsw_commuted_before negate_select_of_op_vs_negated_op_nsw_commuted_after
  simp_alive_peephole
  intros
  ---BEGIN negate_select_of_op_vs_negated_op_nsw_commuted
  all_goals (try extract_goal ; sorry)
  ---END negate_select_of_op_vs_negated_op_nsw_commuted



def negate_select_of_op_vs_negated_op_nsw_xyyx_before := [llvm|
{
^0(%arg14 : i8, %arg15 : i8, %arg16 : i8, %arg17 : i1):
  %0 = llvm.sub %arg14, %arg15 overflow<nsw> : i8
  %1 = llvm.sub %arg15, %arg14 overflow<nsw> : i8
  %2 = "llvm.select"(%arg17, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %3 = llvm.sub %arg16, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def negate_select_of_op_vs_negated_op_nsw_xyyx_after := [llvm|
{
^0(%arg14 : i8, %arg15 : i8, %arg16 : i8, %arg17 : i1):
  %0 = llvm.sub %arg14, %arg15 : i8
  %1 = llvm.sub %arg15, %arg14 : i8
  %2 = "llvm.select"(%arg17, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %3 = llvm.add %2, %arg16 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem negate_select_of_op_vs_negated_op_nsw_xyyx_proof : negate_select_of_op_vs_negated_op_nsw_xyyx_before ⊑ negate_select_of_op_vs_negated_op_nsw_xyyx_after := by
  unfold negate_select_of_op_vs_negated_op_nsw_xyyx_before negate_select_of_op_vs_negated_op_nsw_xyyx_after
  simp_alive_peephole
  intros
  ---BEGIN negate_select_of_op_vs_negated_op_nsw_xyyx
  all_goals (try extract_goal ; sorry)
  ---END negate_select_of_op_vs_negated_op_nsw_xyyx


