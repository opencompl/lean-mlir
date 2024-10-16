
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
section glshr_statements
                                                    
def lshr_exact_before := [llvm|
{
^0(%arg183 : i8):
  %0 = "llvm.mlir.constant"() <{value = 2 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 4 : i8}> : () -> i8
  %2 = llvm.shl %arg183, %0 : i8
  %3 = llvm.add %2, %1 : i8
  %4 = llvm.lshr %3, %0 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def lshr_exact_after := [llvm|
{
^0(%arg183 : i8):
  %0 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 63 : i8}> : () -> i8
  %2 = llvm.add %arg183, %0 : i8
  %3 = llvm.and %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem lshr_exact_proof : lshr_exact_before ⊑ lshr_exact_after := by
  unfold lshr_exact_before lshr_exact_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN lshr_exact
  all_goals (try extract_goal ; sorry)
  ---END lshr_exact



def shl_add_before := [llvm|
{
^0(%arg179 : i8, %arg180 : i8):
  %0 = "llvm.mlir.constant"() <{value = 2 : i8}> : () -> i8
  %1 = llvm.shl %arg179, %0 : i8
  %2 = llvm.add %1, %arg180 : i8
  %3 = llvm.lshr %2, %0 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def shl_add_after := [llvm|
{
^0(%arg179 : i8, %arg180 : i8):
  %0 = "llvm.mlir.constant"() <{value = 2 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 63 : i8}> : () -> i8
  %2 = llvm.lshr %arg180, %0 : i8
  %3 = llvm.add %2, %arg179 : i8
  %4 = llvm.and %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
theorem shl_add_proof : shl_add_before ⊑ shl_add_after := by
  unfold shl_add_before shl_add_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN shl_add
  all_goals (try extract_goal ; sorry)
  ---END shl_add



def mul_splat_fold_before := [llvm|
{
^0(%arg161 : i32):
  %0 = "llvm.mlir.constant"() <{value = 65537 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
  %2 = llvm.mul %arg161, %0 overflow<nuw> : i32
  %3 = llvm.lshr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def mul_splat_fold_after := [llvm|
{
^0(%arg161 : i32):
  "llvm.return"(%arg161) : (i32) -> ()
}
]
theorem mul_splat_fold_proof : mul_splat_fold_before ⊑ mul_splat_fold_after := by
  unfold mul_splat_fold_before mul_splat_fold_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN mul_splat_fold
  all_goals (try extract_goal ; sorry)
  ---END mul_splat_fold



def shl_add_lshr_flag_preservation_before := [llvm|
{
^0(%arg157 : i32, %arg158 : i32, %arg159 : i32):
  %0 = llvm.shl %arg157, %arg158 overflow<nuw> : i32
  %1 = llvm.add %0, %arg159 overflow<nsw,nuw> : i32
  %2 = llvm.lshr %1, %arg158 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def shl_add_lshr_flag_preservation_after := [llvm|
{
^0(%arg157 : i32, %arg158 : i32, %arg159 : i32):
  %0 = llvm.lshr %arg159, %arg158 : i32
  %1 = llvm.add %0, %arg157 overflow<nsw,nuw> : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem shl_add_lshr_flag_preservation_proof : shl_add_lshr_flag_preservation_before ⊑ shl_add_lshr_flag_preservation_after := by
  unfold shl_add_lshr_flag_preservation_before shl_add_lshr_flag_preservation_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN shl_add_lshr_flag_preservation
  all_goals (try extract_goal ; sorry)
  ---END shl_add_lshr_flag_preservation



def shl_add_lshr_before := [llvm|
{
^0(%arg154 : i32, %arg155 : i32, %arg156 : i32):
  %0 = llvm.shl %arg154, %arg155 overflow<nuw> : i32
  %1 = llvm.add %0, %arg156 overflow<nuw> : i32
  %2 = llvm.lshr %1, %arg155 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def shl_add_lshr_after := [llvm|
{
^0(%arg154 : i32, %arg155 : i32, %arg156 : i32):
  %0 = llvm.lshr %arg156, %arg155 : i32
  %1 = llvm.add %0, %arg154 overflow<nuw> : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem shl_add_lshr_proof : shl_add_lshr_before ⊑ shl_add_lshr_after := by
  unfold shl_add_lshr_before shl_add_lshr_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN shl_add_lshr
  all_goals (try extract_goal ; sorry)
  ---END shl_add_lshr



def shl_add_lshr_comm_before := [llvm|
{
^0(%arg151 : i32, %arg152 : i32, %arg153 : i32):
  %0 = llvm.shl %arg151, %arg152 overflow<nuw> : i32
  %1 = llvm.mul %arg153, %arg153 : i32
  %2 = llvm.add %1, %0 overflow<nuw> : i32
  %3 = llvm.lshr %2, %arg152 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def shl_add_lshr_comm_after := [llvm|
{
^0(%arg151 : i32, %arg152 : i32, %arg153 : i32):
  %0 = llvm.mul %arg153, %arg153 : i32
  %1 = llvm.lshr %0, %arg152 : i32
  %2 = llvm.add %1, %arg151 overflow<nuw> : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem shl_add_lshr_comm_proof : shl_add_lshr_comm_before ⊑ shl_add_lshr_comm_after := by
  unfold shl_add_lshr_comm_before shl_add_lshr_comm_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN shl_add_lshr_comm
  all_goals (try extract_goal ; sorry)
  ---END shl_add_lshr_comm



def shl_sub_lshr_before := [llvm|
{
^0(%arg139 : i32, %arg140 : i32, %arg141 : i32):
  %0 = llvm.shl %arg139, %arg140 overflow<nuw> : i32
  %1 = llvm.sub %0, %arg141 overflow<nsw,nuw> : i32
  %2 = llvm.lshr %1, %arg140 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def shl_sub_lshr_after := [llvm|
{
^0(%arg139 : i32, %arg140 : i32, %arg141 : i32):
  %0 = llvm.lshr %arg141, %arg140 : i32
  %1 = llvm.sub %arg139, %0 overflow<nsw,nuw> : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem shl_sub_lshr_proof : shl_sub_lshr_before ⊑ shl_sub_lshr_after := by
  unfold shl_sub_lshr_before shl_sub_lshr_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN shl_sub_lshr
  all_goals (try extract_goal ; sorry)
  ---END shl_sub_lshr



def shl_sub_lshr_reverse_before := [llvm|
{
^0(%arg136 : i32, %arg137 : i32, %arg138 : i32):
  %0 = llvm.shl %arg136, %arg137 overflow<nuw> : i32
  %1 = llvm.sub %arg138, %0 overflow<nsw,nuw> : i32
  %2 = llvm.lshr %1, %arg137 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def shl_sub_lshr_reverse_after := [llvm|
{
^0(%arg136 : i32, %arg137 : i32, %arg138 : i32):
  %0 = llvm.lshr %arg138, %arg137 : i32
  %1 = llvm.sub %0, %arg136 overflow<nsw,nuw> : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem shl_sub_lshr_reverse_proof : shl_sub_lshr_reverse_before ⊑ shl_sub_lshr_reverse_after := by
  unfold shl_sub_lshr_reverse_before shl_sub_lshr_reverse_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN shl_sub_lshr_reverse
  all_goals (try extract_goal ; sorry)
  ---END shl_sub_lshr_reverse



def shl_sub_lshr_reverse_no_nsw_before := [llvm|
{
^0(%arg133 : i32, %arg134 : i32, %arg135 : i32):
  %0 = llvm.shl %arg133, %arg134 overflow<nuw> : i32
  %1 = llvm.sub %arg135, %0 overflow<nuw> : i32
  %2 = llvm.lshr %1, %arg134 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def shl_sub_lshr_reverse_no_nsw_after := [llvm|
{
^0(%arg133 : i32, %arg134 : i32, %arg135 : i32):
  %0 = llvm.lshr %arg135, %arg134 : i32
  %1 = llvm.sub %0, %arg133 overflow<nuw> : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem shl_sub_lshr_reverse_no_nsw_proof : shl_sub_lshr_reverse_no_nsw_before ⊑ shl_sub_lshr_reverse_no_nsw_after := by
  unfold shl_sub_lshr_reverse_no_nsw_before shl_sub_lshr_reverse_no_nsw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN shl_sub_lshr_reverse_no_nsw
  all_goals (try extract_goal ; sorry)
  ---END shl_sub_lshr_reverse_no_nsw



def shl_sub_lshr_reverse_nsw_on_op1_before := [llvm|
{
^0(%arg130 : i32, %arg131 : i32, %arg132 : i32):
  %0 = llvm.shl %arg130, %arg131 overflow<nsw,nuw> : i32
  %1 = llvm.sub %arg132, %0 overflow<nuw> : i32
  %2 = llvm.lshr %1, %arg131 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def shl_sub_lshr_reverse_nsw_on_op1_after := [llvm|
{
^0(%arg130 : i32, %arg131 : i32, %arg132 : i32):
  %0 = llvm.lshr %arg132, %arg131 : i32
  %1 = llvm.sub %0, %arg130 overflow<nuw> : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem shl_sub_lshr_reverse_nsw_on_op1_proof : shl_sub_lshr_reverse_nsw_on_op1_before ⊑ shl_sub_lshr_reverse_nsw_on_op1_after := by
  unfold shl_sub_lshr_reverse_nsw_on_op1_before shl_sub_lshr_reverse_nsw_on_op1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN shl_sub_lshr_reverse_nsw_on_op1
  all_goals (try extract_goal ; sorry)
  ---END shl_sub_lshr_reverse_nsw_on_op1



def shl_or_lshr_before := [llvm|
{
^0(%arg112 : i32, %arg113 : i32, %arg114 : i32):
  %0 = llvm.shl %arg112, %arg113 overflow<nuw> : i32
  %1 = llvm.or %0, %arg114 : i32
  %2 = llvm.lshr %1, %arg113 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def shl_or_lshr_after := [llvm|
{
^0(%arg112 : i32, %arg113 : i32, %arg114 : i32):
  %0 = llvm.lshr %arg114, %arg113 : i32
  %1 = llvm.or %0, %arg112 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem shl_or_lshr_proof : shl_or_lshr_before ⊑ shl_or_lshr_after := by
  unfold shl_or_lshr_before shl_or_lshr_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN shl_or_lshr
  all_goals (try extract_goal ; sorry)
  ---END shl_or_lshr



def shl_or_disjoint_lshr_before := [llvm|
{
^0(%arg109 : i32, %arg110 : i32, %arg111 : i32):
  %0 = llvm.shl %arg109, %arg110 overflow<nuw> : i32
  %1 = llvm.or %0, %arg111 : i32
  %2 = llvm.lshr %1, %arg110 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def shl_or_disjoint_lshr_after := [llvm|
{
^0(%arg109 : i32, %arg110 : i32, %arg111 : i32):
  %0 = llvm.lshr %arg111, %arg110 : i32
  %1 = llvm.or %0, %arg109 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem shl_or_disjoint_lshr_proof : shl_or_disjoint_lshr_before ⊑ shl_or_disjoint_lshr_after := by
  unfold shl_or_disjoint_lshr_before shl_or_disjoint_lshr_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN shl_or_disjoint_lshr
  all_goals (try extract_goal ; sorry)
  ---END shl_or_disjoint_lshr



def shl_or_lshr_comm_before := [llvm|
{
^0(%arg106 : i32, %arg107 : i32, %arg108 : i32):
  %0 = llvm.shl %arg106, %arg107 overflow<nuw> : i32
  %1 = llvm.or %arg108, %0 : i32
  %2 = llvm.lshr %1, %arg107 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def shl_or_lshr_comm_after := [llvm|
{
^0(%arg106 : i32, %arg107 : i32, %arg108 : i32):
  %0 = llvm.lshr %arg108, %arg107 : i32
  %1 = llvm.or %0, %arg106 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem shl_or_lshr_comm_proof : shl_or_lshr_comm_before ⊑ shl_or_lshr_comm_after := by
  unfold shl_or_lshr_comm_before shl_or_lshr_comm_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN shl_or_lshr_comm
  all_goals (try extract_goal ; sorry)
  ---END shl_or_lshr_comm



def shl_or_disjoint_lshr_comm_before := [llvm|
{
^0(%arg103 : i32, %arg104 : i32, %arg105 : i32):
  %0 = llvm.shl %arg103, %arg104 overflow<nuw> : i32
  %1 = llvm.or %arg105, %0 : i32
  %2 = llvm.lshr %1, %arg104 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def shl_or_disjoint_lshr_comm_after := [llvm|
{
^0(%arg103 : i32, %arg104 : i32, %arg105 : i32):
  %0 = llvm.lshr %arg105, %arg104 : i32
  %1 = llvm.or %0, %arg103 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem shl_or_disjoint_lshr_comm_proof : shl_or_disjoint_lshr_comm_before ⊑ shl_or_disjoint_lshr_comm_after := by
  unfold shl_or_disjoint_lshr_comm_before shl_or_disjoint_lshr_comm_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN shl_or_disjoint_lshr_comm
  all_goals (try extract_goal ; sorry)
  ---END shl_or_disjoint_lshr_comm



def shl_xor_lshr_before := [llvm|
{
^0(%arg100 : i32, %arg101 : i32, %arg102 : i32):
  %0 = llvm.shl %arg100, %arg101 overflow<nuw> : i32
  %1 = llvm.xor %0, %arg102 : i32
  %2 = llvm.lshr %1, %arg101 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def shl_xor_lshr_after := [llvm|
{
^0(%arg100 : i32, %arg101 : i32, %arg102 : i32):
  %0 = llvm.lshr %arg102, %arg101 : i32
  %1 = llvm.xor %0, %arg100 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem shl_xor_lshr_proof : shl_xor_lshr_before ⊑ shl_xor_lshr_after := by
  unfold shl_xor_lshr_before shl_xor_lshr_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN shl_xor_lshr
  all_goals (try extract_goal ; sorry)
  ---END shl_xor_lshr



def shl_xor_lshr_comm_before := [llvm|
{
^0(%arg97 : i32, %arg98 : i32, %arg99 : i32):
  %0 = llvm.shl %arg97, %arg98 overflow<nuw> : i32
  %1 = llvm.xor %arg99, %0 : i32
  %2 = llvm.lshr %1, %arg98 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def shl_xor_lshr_comm_after := [llvm|
{
^0(%arg97 : i32, %arg98 : i32, %arg99 : i32):
  %0 = llvm.lshr %arg99, %arg98 : i32
  %1 = llvm.xor %0, %arg97 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem shl_xor_lshr_comm_proof : shl_xor_lshr_comm_before ⊑ shl_xor_lshr_comm_after := by
  unfold shl_xor_lshr_comm_before shl_xor_lshr_comm_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN shl_xor_lshr_comm
  all_goals (try extract_goal ; sorry)
  ---END shl_xor_lshr_comm



def shl_and_lshr_before := [llvm|
{
^0(%arg94 : i32, %arg95 : i32, %arg96 : i32):
  %0 = llvm.shl %arg94, %arg95 overflow<nuw> : i32
  %1 = llvm.and %0, %arg96 : i32
  %2 = llvm.lshr %1, %arg95 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def shl_and_lshr_after := [llvm|
{
^0(%arg94 : i32, %arg95 : i32, %arg96 : i32):
  %0 = llvm.lshr %arg96, %arg95 : i32
  %1 = llvm.and %0, %arg94 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem shl_and_lshr_proof : shl_and_lshr_before ⊑ shl_and_lshr_after := by
  unfold shl_and_lshr_before shl_and_lshr_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN shl_and_lshr
  all_goals (try extract_goal ; sorry)
  ---END shl_and_lshr



def shl_and_lshr_comm_before := [llvm|
{
^0(%arg91 : i32, %arg92 : i32, %arg93 : i32):
  %0 = llvm.shl %arg91, %arg92 overflow<nuw> : i32
  %1 = llvm.and %arg93, %0 : i32
  %2 = llvm.lshr %1, %arg92 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def shl_and_lshr_comm_after := [llvm|
{
^0(%arg91 : i32, %arg92 : i32, %arg93 : i32):
  %0 = llvm.lshr %arg93, %arg92 : i32
  %1 = llvm.and %0, %arg91 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem shl_and_lshr_comm_proof : shl_and_lshr_comm_before ⊑ shl_and_lshr_comm_after := by
  unfold shl_and_lshr_comm_before shl_and_lshr_comm_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN shl_and_lshr_comm
  all_goals (try extract_goal ; sorry)
  ---END shl_and_lshr_comm



def shl_lshr_and_exact_before := [llvm|
{
^0(%arg88 : i32, %arg89 : i32, %arg90 : i32):
  %0 = llvm.shl %arg88, %arg89 overflow<nuw> : i32
  %1 = llvm.and %0, %arg90 : i32
  %2 = llvm.lshr %1, %arg89 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def shl_lshr_and_exact_after := [llvm|
{
^0(%arg88 : i32, %arg89 : i32, %arg90 : i32):
  %0 = llvm.lshr %arg90, %arg89 : i32
  %1 = llvm.and %0, %arg88 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem shl_lshr_and_exact_proof : shl_lshr_and_exact_before ⊑ shl_lshr_and_exact_after := by
  unfold shl_lshr_and_exact_before shl_lshr_and_exact_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN shl_lshr_and_exact
  all_goals (try extract_goal ; sorry)
  ---END shl_lshr_and_exact



def mul_splat_fold_no_nuw_before := [llvm|
{
^0(%arg79 : i32):
  %0 = "llvm.mlir.constant"() <{value = 65537 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
  %2 = llvm.mul %arg79, %0 overflow<nsw> : i32
  %3 = llvm.lshr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def mul_splat_fold_no_nuw_after := [llvm|
{
^0(%arg79 : i32):
  %0 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
  %1 = llvm.lshr %arg79, %0 : i32
  %2 = llvm.add %arg79, %1 overflow<nsw> : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem mul_splat_fold_no_nuw_proof : mul_splat_fold_no_nuw_before ⊑ mul_splat_fold_no_nuw_after := by
  unfold mul_splat_fold_no_nuw_before mul_splat_fold_no_nuw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN mul_splat_fold_no_nuw
  all_goals (try extract_goal ; sorry)
  ---END mul_splat_fold_no_nuw



def mul_splat_fold_too_narrow_before := [llvm|
{
^0(%arg77 : i2):
  %0 = "llvm.mlir.constant"() <{value = -2 : i2}> : () -> i2
  %1 = "llvm.mlir.constant"() <{value = 1 : i2}> : () -> i2
  %2 = llvm.mul %arg77, %0 overflow<nuw> : i2
  %3 = llvm.lshr %2, %1 : i2
  "llvm.return"(%3) : (i2) -> ()
}
]
def mul_splat_fold_too_narrow_after := [llvm|
{
^0(%arg77 : i2):
  "llvm.return"(%arg77) : (i2) -> ()
}
]
theorem mul_splat_fold_too_narrow_proof : mul_splat_fold_too_narrow_before ⊑ mul_splat_fold_too_narrow_after := by
  unfold mul_splat_fold_too_narrow_before mul_splat_fold_too_narrow_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN mul_splat_fold_too_narrow
  all_goals (try extract_goal ; sorry)
  ---END mul_splat_fold_too_narrow



def negative_and_odd_before := [llvm|
{
^0(%arg76 : i32):
  %0 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 31 : i32}> : () -> i32
  %2 = llvm.srem %arg76, %0 : i32
  %3 = llvm.lshr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def negative_and_odd_after := [llvm|
{
^0(%arg76 : i32):
  %0 = "llvm.mlir.constant"() <{value = 31 : i32}> : () -> i32
  %1 = llvm.lshr %arg76, %0 : i32
  %2 = llvm.and %1, %arg76 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem negative_and_odd_proof : negative_and_odd_before ⊑ negative_and_odd_after := by
  unfold negative_and_odd_before negative_and_odd_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN negative_and_odd
  all_goals (try extract_goal ; sorry)
  ---END negative_and_odd


