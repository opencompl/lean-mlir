import SSA.Projects.InstCombine.tests.LLVM.gsubhfromhsub_proof
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)

set_option linter.deprecated false
set_option linter.unreachableTactic false
set_option linter.unusedTactic false
                                                                       
def t0_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.sub %arg0, %arg1 : i8
  %1 = llvm.sub %0, %arg2 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def t0_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.add %arg1, %arg2 : i8
  %1 = llvm.sub %arg0, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem t0_proof : t0_before ⊑ t0_after := by
  unfold t0_before t0_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN t0
  all_goals (try extract_goal ; sorry)
  ---END t0



def t1_flags_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.sub %arg0, %arg1 : i8
  %1 = llvm.sub %0, %arg2 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def t1_flags_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.add %arg1, %arg2 : i8
  %1 = llvm.sub %arg0, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem t1_flags_proof : t1_flags_before ⊑ t1_flags_after := by
  unfold t1_flags_before t1_flags_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN t1_flags
  all_goals (try extract_goal ; sorry)
  ---END t1_flags



def t1_flags_nuw_only_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.sub %arg0, %arg1 : i8
  %1 = llvm.sub %0, %arg2 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def t1_flags_nuw_only_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.add %arg1, %arg2 : i8
  %1 = llvm.sub %arg0, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem t1_flags_nuw_only_proof : t1_flags_nuw_only_before ⊑ t1_flags_nuw_only_after := by
  unfold t1_flags_nuw_only_before t1_flags_nuw_only_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN t1_flags_nuw_only
  all_goals (try extract_goal ; sorry)
  ---END t1_flags_nuw_only



def t1_flags_sub_nsw_sub_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.sub %arg0, %arg1 : i8
  %1 = llvm.sub %0, %arg2 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def t1_flags_sub_nsw_sub_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.add %arg1, %arg2 : i8
  %1 = llvm.sub %arg0, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem t1_flags_sub_nsw_sub_proof : t1_flags_sub_nsw_sub_before ⊑ t1_flags_sub_nsw_sub_after := by
  unfold t1_flags_sub_nsw_sub_before t1_flags_sub_nsw_sub_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN t1_flags_sub_nsw_sub
  all_goals (try extract_goal ; sorry)
  ---END t1_flags_sub_nsw_sub



def t1_flags_nuw_first_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.sub %arg0, %arg1 : i8
  %1 = llvm.sub %0, %arg2 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def t1_flags_nuw_first_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.add %arg1, %arg2 : i8
  %1 = llvm.sub %arg0, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem t1_flags_nuw_first_proof : t1_flags_nuw_first_before ⊑ t1_flags_nuw_first_after := by
  unfold t1_flags_nuw_first_before t1_flags_nuw_first_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN t1_flags_nuw_first
  all_goals (try extract_goal ; sorry)
  ---END t1_flags_nuw_first



def t1_flags_nuw_second_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.sub %arg0, %arg1 : i8
  %1 = llvm.sub %0, %arg2 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def t1_flags_nuw_second_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.add %arg1, %arg2 : i8
  %1 = llvm.sub %arg0, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem t1_flags_nuw_second_proof : t1_flags_nuw_second_before ⊑ t1_flags_nuw_second_after := by
  unfold t1_flags_nuw_second_before t1_flags_nuw_second_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN t1_flags_nuw_second
  all_goals (try extract_goal ; sorry)
  ---END t1_flags_nuw_second



def t1_flags_nuw_nsw_first_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.sub %arg0, %arg1 : i8
  %1 = llvm.sub %0, %arg2 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def t1_flags_nuw_nsw_first_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.add %arg1, %arg2 : i8
  %1 = llvm.sub %arg0, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem t1_flags_nuw_nsw_first_proof : t1_flags_nuw_nsw_first_before ⊑ t1_flags_nuw_nsw_first_after := by
  unfold t1_flags_nuw_nsw_first_before t1_flags_nuw_nsw_first_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN t1_flags_nuw_nsw_first
  all_goals (try extract_goal ; sorry)
  ---END t1_flags_nuw_nsw_first



def t1_flags_nuw_nsw_second_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.sub %arg0, %arg1 : i8
  %1 = llvm.sub %0, %arg2 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def t1_flags_nuw_nsw_second_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.add %arg1, %arg2 : i8
  %1 = llvm.sub %arg0, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem t1_flags_nuw_nsw_second_proof : t1_flags_nuw_nsw_second_before ⊑ t1_flags_nuw_nsw_second_after := by
  unfold t1_flags_nuw_nsw_second_before t1_flags_nuw_nsw_second_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN t1_flags_nuw_nsw_second
  all_goals (try extract_goal ; sorry)
  ---END t1_flags_nuw_nsw_second



def t3_c0_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg0 : i8
  %2 = llvm.sub %1, %arg1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def t3_c0_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
  %1 = llvm.add %arg0, %arg1 : i8
  %2 = llvm.sub %0, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem t3_c0_proof : t3_c0_before ⊑ t3_c0_after := by
  unfold t3_c0_before t3_c0_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN t3_c0
  all_goals (try extract_goal ; sorry)
  ---END t3_c0



def t4_c1_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
  %1 = llvm.sub %arg0, %0 : i8
  %2 = llvm.sub %1, %arg1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def t4_c1_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = -42 : i8}> : () -> i8
  %1 = llvm.add %arg0, %0 : i8
  %2 = llvm.sub %1, %arg1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem t4_c1_proof : t4_c1_before ⊑ t4_c1_after := by
  unfold t4_c1_before t4_c1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN t4_c1
  all_goals (try extract_goal ; sorry)
  ---END t4_c1



def t5_c2_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
  %1 = llvm.sub %arg0, %arg1 : i8
  %2 = llvm.sub %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def t5_c2_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = -42 : i8}> : () -> i8
  %1 = llvm.sub %arg0, %arg1 : i8
  %2 = llvm.add %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem t5_c2_proof : t5_c2_before ⊑ t5_c2_after := by
  unfold t5_c2_before t5_c2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN t5_c2
  all_goals (try extract_goal ; sorry)
  ---END t5_c2



def t9_c0_c2_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 24 : i8}> : () -> i8
  %2 = llvm.sub %0, %arg0 : i8
  %3 = llvm.sub %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def t9_c0_c2_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 18 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem t9_c0_c2_proof : t9_c0_c2_before ⊑ t9_c0_c2_after := by
  unfold t9_c0_c2_before t9_c0_c2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN t9_c0_c2
  apply t9_c0_c2_thm
  ---END t9_c0_c2



def t10_c1_c2_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 24 : i8}> : () -> i8
  %2 = llvm.sub %arg0, %0 : i8
  %3 = llvm.sub %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def t10_c1_c2_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = -66 : i8}> : () -> i8
  %1 = llvm.add %arg0, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem t10_c1_c2_proof : t10_c1_c2_before ⊑ t10_c1_c2_after := by
  unfold t10_c1_c2_before t10_c1_c2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN t10_c1_c2
  all_goals (try extract_goal ; sorry)
  ---END t10_c1_c2


