import SSA.Projects.InstCombine.tests.LLVM.gmulhpow2_proof
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
section gmulhpow2_statements
                                                    
def shl_add_log_may_cause_poison_pr62175_fail_before := [llvm|
{
^0(%arg4 : i8, %arg5 : i8):
  %0 = "llvm.mlir.constant"() <{value = 4 : i8}> : () -> i8
  %1 = llvm.shl %0, %arg4 : i8
  %2 = llvm.mul %arg5, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def shl_add_log_may_cause_poison_pr62175_fail_after := [llvm|
{
^0(%arg4 : i8, %arg5 : i8):
  %0 = "llvm.mlir.constant"() <{value = 4 : i8}> : () -> i8
  %1 = llvm.shl %0, %arg4 : i8
  %2 = llvm.mul %1, %arg5 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem shl_add_log_may_cause_poison_pr62175_fail_proof : shl_add_log_may_cause_poison_pr62175_fail_before ⊑ shl_add_log_may_cause_poison_pr62175_fail_after := by
  unfold shl_add_log_may_cause_poison_pr62175_fail_before shl_add_log_may_cause_poison_pr62175_fail_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN shl_add_log_may_cause_poison_pr62175_fail
  apply shl_add_log_may_cause_poison_pr62175_fail_thm
  ---END shl_add_log_may_cause_poison_pr62175_fail



def shl_add_log_may_cause_poison_pr62175_with_nuw_before := [llvm|
{
^0(%arg2 : i8, %arg3 : i8):
  %0 = "llvm.mlir.constant"() <{value = 4 : i8}> : () -> i8
  %1 = llvm.shl %0, %arg2 : i8
  %2 = llvm.mul %arg3, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def shl_add_log_may_cause_poison_pr62175_with_nuw_after := [llvm|
{
^0(%arg2 : i8, %arg3 : i8):
  %0 = "llvm.mlir.constant"() <{value = 2 : i8}> : () -> i8
  %1 = llvm.add %arg2, %0 : i8
  %2 = llvm.shl %arg3, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem shl_add_log_may_cause_poison_pr62175_with_nuw_proof : shl_add_log_may_cause_poison_pr62175_with_nuw_before ⊑ shl_add_log_may_cause_poison_pr62175_with_nuw_after := by
  unfold shl_add_log_may_cause_poison_pr62175_with_nuw_before shl_add_log_may_cause_poison_pr62175_with_nuw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN shl_add_log_may_cause_poison_pr62175_with_nuw
  apply shl_add_log_may_cause_poison_pr62175_with_nuw_thm
  ---END shl_add_log_may_cause_poison_pr62175_with_nuw



def shl_add_log_may_cause_poison_pr62175_with_nsw_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 4 : i8}> : () -> i8
  %1 = llvm.shl %0, %arg0 : i8
  %2 = llvm.mul %arg1, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def shl_add_log_may_cause_poison_pr62175_with_nsw_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 2 : i8}> : () -> i8
  %1 = llvm.add %arg0, %0 : i8
  %2 = llvm.shl %arg1, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem shl_add_log_may_cause_poison_pr62175_with_nsw_proof : shl_add_log_may_cause_poison_pr62175_with_nsw_before ⊑ shl_add_log_may_cause_poison_pr62175_with_nsw_after := by
  unfold shl_add_log_may_cause_poison_pr62175_with_nsw_before shl_add_log_may_cause_poison_pr62175_with_nsw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN shl_add_log_may_cause_poison_pr62175_with_nsw
  apply shl_add_log_may_cause_poison_pr62175_with_nsw_thm
  ---END shl_add_log_may_cause_poison_pr62175_with_nsw


