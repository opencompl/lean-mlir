
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
section gdivhshift_statements
                                                    
def t7_before := [llvm|
{
^0(%arg209 : i32):
  %0 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %1 = llvm.shl %arg209, %0 overflow<nsw> : i32
  %2 = llvm.sdiv %1, %arg209 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def t7_after := [llvm|
{
^0(%arg209 : i32):
  %0 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem t7_proof : t7_before ⊑ t7_after := by
  unfold t7_before t7_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN t7
  all_goals (try extract_goal ; sorry)
  ---END t7



def t10_before := [llvm|
{
^0(%arg205 : i32, %arg206 : i32):
  %0 = llvm.shl %arg205, %arg206 overflow<nsw> : i32
  %1 = llvm.sdiv %0, %arg205 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
def t10_after := [llvm|
{
^0(%arg205 : i32, %arg206 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = llvm.shl %0, %arg206 overflow<nsw,nuw> : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem t10_proof : t10_before ⊑ t10_after := by
  unfold t10_before t10_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN t10
  all_goals (try extract_goal ; sorry)
  ---END t10



def sdiv_mul_shl_nsw_before := [llvm|
{
^0(%arg193 : i5, %arg194 : i5, %arg195 : i5):
  %0 = llvm.mul %arg193, %arg194 overflow<nsw> : i5
  %1 = llvm.shl %arg193, %arg195 overflow<nsw> : i5
  %2 = llvm.sdiv %0, %1 : i5
  "llvm.return"(%2) : (i5) -> ()
}
]
def sdiv_mul_shl_nsw_after := [llvm|
{
^0(%arg193 : i5, %arg194 : i5, %arg195 : i5):
  %0 = "llvm.mlir.constant"() <{value = 1 : i5}> : () -> i5
  %1 = llvm.shl %0, %arg195 overflow<nuw> : i5
  %2 = llvm.sdiv %arg194, %1 : i5
  "llvm.return"(%2) : (i5) -> ()
}
]
theorem sdiv_mul_shl_nsw_proof : sdiv_mul_shl_nsw_before ⊑ sdiv_mul_shl_nsw_after := by
  unfold sdiv_mul_shl_nsw_before sdiv_mul_shl_nsw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN sdiv_mul_shl_nsw
  all_goals (try extract_goal ; sorry)
  ---END sdiv_mul_shl_nsw



def sdiv_mul_shl_nsw_exact_commute1_before := [llvm|
{
^0(%arg190 : i5, %arg191 : i5, %arg192 : i5):
  %0 = llvm.mul %arg191, %arg190 overflow<nsw> : i5
  %1 = llvm.shl %arg190, %arg192 overflow<nsw> : i5
  %2 = llvm.sdiv %0, %1 : i5
  "llvm.return"(%2) : (i5) -> ()
}
]
def sdiv_mul_shl_nsw_exact_commute1_after := [llvm|
{
^0(%arg190 : i5, %arg191 : i5, %arg192 : i5):
  %0 = "llvm.mlir.constant"() <{value = 1 : i5}> : () -> i5
  %1 = llvm.shl %0, %arg192 overflow<nuw> : i5
  %2 = llvm.sdiv %arg191, %1 : i5
  "llvm.return"(%2) : (i5) -> ()
}
]
theorem sdiv_mul_shl_nsw_exact_commute1_proof : sdiv_mul_shl_nsw_exact_commute1_before ⊑ sdiv_mul_shl_nsw_exact_commute1_after := by
  unfold sdiv_mul_shl_nsw_exact_commute1_before sdiv_mul_shl_nsw_exact_commute1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN sdiv_mul_shl_nsw_exact_commute1
  all_goals (try extract_goal ; sorry)
  ---END sdiv_mul_shl_nsw_exact_commute1



def sdiv_shl_shl_nsw2_nuw_before := [llvm|
{
^0(%arg82 : i8, %arg83 : i8, %arg84 : i8):
  %0 = llvm.shl %arg82, %arg84 overflow<nsw> : i8
  %1 = llvm.shl %arg83, %arg84 overflow<nsw,nuw> : i8
  %2 = llvm.sdiv %0, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def sdiv_shl_shl_nsw2_nuw_after := [llvm|
{
^0(%arg82 : i8, %arg83 : i8, %arg84 : i8):
  %0 = llvm.sdiv %arg82, %arg83 : i8
  "llvm.return"(%0) : (i8) -> ()
}
]
theorem sdiv_shl_shl_nsw2_nuw_proof : sdiv_shl_shl_nsw2_nuw_before ⊑ sdiv_shl_shl_nsw2_nuw_after := by
  unfold sdiv_shl_shl_nsw2_nuw_before sdiv_shl_shl_nsw2_nuw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN sdiv_shl_shl_nsw2_nuw
  all_goals (try extract_goal ; sorry)
  ---END sdiv_shl_shl_nsw2_nuw



def sdiv_shl_pair_const_before := [llvm|
{
^0(%arg47 : i32):
  %0 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %2 = llvm.shl %arg47, %0 overflow<nsw> : i32
  %3 = llvm.shl %arg47, %1 overflow<nsw> : i32
  %4 = llvm.sdiv %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def sdiv_shl_pair_const_after := [llvm|
{
^0(%arg47 : i32):
  %0 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem sdiv_shl_pair_const_proof : sdiv_shl_pair_const_before ⊑ sdiv_shl_pair_const_after := by
  unfold sdiv_shl_pair_const_before sdiv_shl_pair_const_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN sdiv_shl_pair_const
  all_goals (try extract_goal ; sorry)
  ---END sdiv_shl_pair_const



def sdiv_shl_pair1_before := [llvm|
{
^0(%arg43 : i32, %arg44 : i32, %arg45 : i32):
  %0 = llvm.shl %arg43, %arg44 overflow<nsw> : i32
  %1 = llvm.shl %arg43, %arg45 overflow<nsw,nuw> : i32
  %2 = llvm.sdiv %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def sdiv_shl_pair1_after := [llvm|
{
^0(%arg43 : i32, %arg44 : i32, %arg45 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = llvm.shl %0, %arg44 overflow<nsw,nuw> : i32
  %2 = llvm.lshr %1, %arg45 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem sdiv_shl_pair1_proof : sdiv_shl_pair1_before ⊑ sdiv_shl_pair1_after := by
  unfold sdiv_shl_pair1_before sdiv_shl_pair1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN sdiv_shl_pair1
  all_goals (try extract_goal ; sorry)
  ---END sdiv_shl_pair1



def sdiv_shl_pair2_before := [llvm|
{
^0(%arg40 : i32, %arg41 : i32, %arg42 : i32):
  %0 = llvm.shl %arg40, %arg41 overflow<nsw,nuw> : i32
  %1 = llvm.shl %arg40, %arg42 overflow<nsw> : i32
  %2 = llvm.sdiv %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def sdiv_shl_pair2_after := [llvm|
{
^0(%arg40 : i32, %arg41 : i32, %arg42 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = llvm.shl %0, %arg41 overflow<nsw,nuw> : i32
  %2 = llvm.lshr %1, %arg42 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem sdiv_shl_pair2_proof : sdiv_shl_pair2_before ⊑ sdiv_shl_pair2_after := by
  unfold sdiv_shl_pair2_before sdiv_shl_pair2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN sdiv_shl_pair2
  all_goals (try extract_goal ; sorry)
  ---END sdiv_shl_pair2



def sdiv_shl_pair3_before := [llvm|
{
^0(%arg37 : i32, %arg38 : i32, %arg39 : i32):
  %0 = llvm.shl %arg37, %arg38 overflow<nsw> : i32
  %1 = llvm.shl %arg37, %arg39 overflow<nsw> : i32
  %2 = llvm.sdiv %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def sdiv_shl_pair3_after := [llvm|
{
^0(%arg37 : i32, %arg38 : i32, %arg39 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = llvm.shl %0, %arg38 overflow<nuw> : i32
  %2 = llvm.lshr %1, %arg39 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem sdiv_shl_pair3_proof : sdiv_shl_pair3_before ⊑ sdiv_shl_pair3_after := by
  unfold sdiv_shl_pair3_before sdiv_shl_pair3_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN sdiv_shl_pair3
  all_goals (try extract_goal ; sorry)
  ---END sdiv_shl_pair3


