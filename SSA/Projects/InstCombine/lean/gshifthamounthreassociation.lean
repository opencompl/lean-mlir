import SSA.Projects.InstCombine.lean.gshifthamounthreassociation_proof
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
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -2 : i32}> : () -> i32
  %2 = llvm.sub %0, %arg1 : i32
  %3 = llvm.lshr %arg0, %2 : i32
  %4 = llvm.add %arg1, %1 : i32
  %5 = llvm.lshr %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def t0_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 30 : i32}> : () -> i32
  %1 = llvm.lshr %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
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



def t6_shl_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -2 : i32}> : () -> i32
  %2 = llvm.sub %0, %arg1 : i32
  %3 = llvm.shl %arg0, %2 : i32
  %4 = llvm.add %arg1, %1 : i32
  %5 = llvm.shl %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def t6_shl_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 30 : i32}> : () -> i32
  %1 = llvm.shl %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem t6_shl_proof : t6_shl_before ⊑ t6_shl_after := by
  unfold t6_shl_before t6_shl_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN t6_shl
  all_goals (try extract_goal ; sorry)
  ---END t6_shl



def t7_ashr_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -2 : i32}> : () -> i32
  %2 = llvm.sub %0, %arg1 : i32
  %3 = llvm.ashr %arg0, %2 : i32
  %4 = llvm.add %arg1, %1 : i32
  %5 = llvm.ashr %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def t7_ashr_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 30 : i32}> : () -> i32
  %1 = llvm.ashr %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem t7_ashr_proof : t7_ashr_before ⊑ t7_ashr_after := by
  unfold t7_ashr_before t7_ashr_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN t7_ashr
  all_goals (try extract_goal ; sorry)
  ---END t7_ashr



def t8_lshr_exact_flag_preservation_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -2 : i32}> : () -> i32
  %2 = llvm.sub %0, %arg1 : i32
  %3 = llvm.lshr %arg0, %2 : i32
  %4 = llvm.add %arg1, %1 : i32
  %5 = llvm.lshr %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def t8_lshr_exact_flag_preservation_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 30 : i32}> : () -> i32
  %1 = llvm.lshr %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem t8_lshr_exact_flag_preservation_proof : t8_lshr_exact_flag_preservation_before ⊑ t8_lshr_exact_flag_preservation_after := by
  unfold t8_lshr_exact_flag_preservation_before t8_lshr_exact_flag_preservation_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN t8_lshr_exact_flag_preservation
  all_goals (try extract_goal ; sorry)
  ---END t8_lshr_exact_flag_preservation



def t9_ashr_exact_flag_preservation_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -2 : i32}> : () -> i32
  %2 = llvm.sub %0, %arg1 : i32
  %3 = llvm.ashr %arg0, %2 : i32
  %4 = llvm.add %arg1, %1 : i32
  %5 = llvm.ashr %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def t9_ashr_exact_flag_preservation_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 30 : i32}> : () -> i32
  %1 = llvm.ashr %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem t9_ashr_exact_flag_preservation_proof : t9_ashr_exact_flag_preservation_before ⊑ t9_ashr_exact_flag_preservation_after := by
  unfold t9_ashr_exact_flag_preservation_before t9_ashr_exact_flag_preservation_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN t9_ashr_exact_flag_preservation
  all_goals (try extract_goal ; sorry)
  ---END t9_ashr_exact_flag_preservation



def t10_shl_nuw_flag_preservation_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -2 : i32}> : () -> i32
  %2 = llvm.sub %0, %arg1 : i32
  %3 = llvm.shl %arg0, %2 : i32
  %4 = llvm.add %arg1, %1 : i32
  %5 = llvm.shl %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def t10_shl_nuw_flag_preservation_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 30 : i32}> : () -> i32
  %1 = llvm.shl %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem t10_shl_nuw_flag_preservation_proof : t10_shl_nuw_flag_preservation_before ⊑ t10_shl_nuw_flag_preservation_after := by
  unfold t10_shl_nuw_flag_preservation_before t10_shl_nuw_flag_preservation_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN t10_shl_nuw_flag_preservation
  all_goals (try extract_goal ; sorry)
  ---END t10_shl_nuw_flag_preservation



def t11_shl_nsw_flag_preservation_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -2 : i32}> : () -> i32
  %2 = llvm.sub %0, %arg1 : i32
  %3 = llvm.shl %arg0, %2 : i32
  %4 = llvm.add %arg1, %1 : i32
  %5 = llvm.shl %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def t11_shl_nsw_flag_preservation_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 30 : i32}> : () -> i32
  %1 = llvm.shl %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem t11_shl_nsw_flag_preservation_proof : t11_shl_nsw_flag_preservation_before ⊑ t11_shl_nsw_flag_preservation_after := by
  unfold t11_shl_nsw_flag_preservation_before t11_shl_nsw_flag_preservation_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN t11_shl_nsw_flag_preservation
  all_goals (try extract_goal ; sorry)
  ---END t11_shl_nsw_flag_preservation


