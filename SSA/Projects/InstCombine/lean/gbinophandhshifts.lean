import SSA.Projects.InstCombine.lean.gbinophandhshifts_proof
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import Batteries.Data.BitVec

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)

set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
set_option linter.unreachableTactic false
set_option linter.unusedTactic false
                                                                       
def shl_and_and_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 4 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 88 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = llvm.shl %arg1, %0 : i8
  %4 = llvm.and %3, %1 : i8
  %5 = llvm.and %2, %4 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def shl_and_and_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 4 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 80 : i8}> : () -> i8
  %2 = llvm.and %arg1, %arg0 : i8
  %3 = llvm.shl %2, %0 : i8
  %4 = llvm.and %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
theorem shl_and_and_proof : shl_and_and_before ⊑ shl_and_and_after := by
  unfold shl_and_and_before shl_and_and_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN shl_and_and
  apply shl_and_and_thm
  ---END shl_and_and



def shl_and_and_fail_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 4 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 5 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{value = 88 : i8}> : () -> i8
  %3 = llvm.shl %arg0, %0 : i8
  %4 = llvm.shl %arg1, %1 : i8
  %5 = llvm.and %4, %2 : i8
  %6 = llvm.and %3, %5 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def shl_and_and_fail_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 4 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 5 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{value = 64 : i8}> : () -> i8
  %3 = llvm.shl %arg0, %0 : i8
  %4 = llvm.shl %arg1, %1 : i8
  %5 = llvm.and %4, %2 : i8
  %6 = llvm.and %3, %5 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
theorem shl_and_and_fail_proof : shl_and_and_fail_before ⊑ shl_and_and_fail_after := by
  unfold shl_and_and_fail_before shl_and_and_fail_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN shl_and_and_fail
  apply shl_and_and_fail_thm
  ---END shl_and_and_fail



def shl_add_add_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 2 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 48 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = llvm.shl %arg1, %0 : i8
  %4 = llvm.add %3, %1 : i8
  %5 = llvm.add %2, %4 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def shl_add_add_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 2 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 48 : i8}> : () -> i8
  %2 = llvm.add %arg1, %arg0 : i8
  %3 = llvm.shl %2, %0 : i8
  %4 = llvm.add %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
theorem shl_add_add_proof : shl_add_add_before ⊑ shl_add_add_after := by
  unfold shl_add_add_before shl_add_add_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN shl_add_add
  apply shl_add_add_thm
  ---END shl_add_add



def shl_and_xor_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 20 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = llvm.shl %arg1, %0 : i8
  %4 = llvm.and %2, %1 : i8
  %5 = llvm.xor %3, %4 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def shl_and_xor_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 10 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %2 = llvm.and %arg0, %0 : i8
  %3 = llvm.xor %2, %arg1 : i8
  %4 = llvm.shl %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
theorem shl_and_xor_proof : shl_and_xor_before ⊑ shl_and_xor_after := by
  unfold shl_and_xor_before shl_and_xor_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN shl_and_xor
  apply shl_and_xor_thm
  ---END shl_and_xor



def shl_and_add_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 119 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = llvm.shl %arg1, %0 : i8
  %4 = llvm.and %3, %1 : i8
  %5 = llvm.add %2, %4 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def shl_and_add_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 59 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %2 = llvm.and %arg1, %0 : i8
  %3 = llvm.add %2, %arg0 : i8
  %4 = llvm.shl %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
theorem shl_and_add_proof : shl_and_add_before ⊑ shl_and_add_after := by
  unfold shl_and_add_before shl_and_add_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN shl_and_add
  apply shl_and_add_thm
  ---END shl_and_add



def lshr_or_and_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 5 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = -58 : i8}> : () -> i8
  %2 = llvm.lshr %arg0, %0 : i8
  %3 = llvm.lshr %arg1, %0 : i8
  %4 = llvm.or %2, %1 : i8
  %5 = llvm.and %4, %3 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def lshr_or_and_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = -64 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 5 : i8}> : () -> i8
  %2 = llvm.or %arg0, %0 : i8
  %3 = llvm.and %2, %arg1 : i8
  %4 = llvm.lshr %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
theorem lshr_or_and_proof : lshr_or_and_before ⊑ lshr_or_and_after := by
  unfold lshr_or_and_before lshr_or_and_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN lshr_or_and
  apply lshr_or_and_thm
  ---END lshr_or_and



def lshr_or_or_fail_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 5 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = -58 : i8}> : () -> i8
  %2 = llvm.lshr %arg0, %0 : i8
  %3 = llvm.lshr %arg1, %0 : i8
  %4 = llvm.or %3, %1 : i8
  %5 = llvm.or %2, %4 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def lshr_or_or_fail_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 5 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = -58 : i8}> : () -> i8
  %2 = llvm.or %arg1, %arg0 : i8
  %3 = llvm.lshr %2, %0 : i8
  %4 = llvm.or %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
theorem lshr_or_or_fail_proof : lshr_or_or_fail_before ⊑ lshr_or_or_fail_after := by
  unfold lshr_or_or_fail_before lshr_or_or_fail_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN lshr_or_or_fail
  all_goals (try extract_goal ; sorry)
  ---END lshr_or_or_fail



def lshr_or_or_no_const_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8, %arg3 : i8):
  %0 = llvm.lshr %arg0, %arg2 : i8
  %1 = llvm.lshr %arg1, %arg2 : i8
  %2 = llvm.or %1, %arg3 : i8
  %3 = llvm.or %0, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def lshr_or_or_no_const_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8, %arg3 : i8):
  %0 = llvm.or %arg1, %arg0 : i8
  %1 = llvm.lshr %0, %arg2 : i8
  %2 = llvm.or %1, %arg3 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem lshr_or_or_no_const_proof : lshr_or_or_no_const_before ⊑ lshr_or_or_no_const_after := by
  unfold lshr_or_or_no_const_before lshr_or_or_no_const_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN lshr_or_or_no_const
  apply lshr_or_or_no_const_thm
  ---END lshr_or_or_no_const



def shl_xor_xor_no_const_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8, %arg3 : i8):
  %0 = llvm.shl %arg0, %arg2 : i8
  %1 = llvm.shl %arg1, %arg2 : i8
  %2 = llvm.xor %1, %arg3 : i8
  %3 = llvm.xor %0, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def shl_xor_xor_no_const_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8, %arg3 : i8):
  %0 = llvm.xor %arg1, %arg0 : i8
  %1 = llvm.shl %0, %arg2 : i8
  %2 = llvm.xor %1, %arg3 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem shl_xor_xor_no_const_proof : shl_xor_xor_no_const_before ⊑ shl_xor_xor_no_const_after := by
  unfold shl_xor_xor_no_const_before shl_xor_xor_no_const_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN shl_xor_xor_no_const
  apply shl_xor_xor_no_const_thm
  ---END shl_xor_xor_no_const



def shl_add_add_no_const_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8, %arg3 : i8):
  %0 = llvm.shl %arg0, %arg2 : i8
  %1 = llvm.shl %arg1, %arg2 : i8
  %2 = llvm.add %1, %arg3 : i8
  %3 = llvm.add %0, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def shl_add_add_no_const_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8, %arg3 : i8):
  %0 = llvm.add %arg1, %arg0 : i8
  %1 = llvm.shl %0, %arg2 : i8
  %2 = llvm.add %1, %arg3 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem shl_add_add_no_const_proof : shl_add_add_no_const_before ⊑ shl_add_add_no_const_after := by
  unfold shl_add_add_no_const_before shl_add_add_no_const_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN shl_add_add_no_const
  apply shl_add_add_no_const_thm
  ---END shl_add_add_no_const



def lshr_xor_or_good_mask_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 4 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 48 : i8}> : () -> i8
  %2 = llvm.lshr %arg0, %0 : i8
  %3 = llvm.lshr %arg1, %0 : i8
  %4 = llvm.xor %3, %1 : i8
  %5 = llvm.or %2, %4 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def lshr_xor_or_good_mask_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 4 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 48 : i8}> : () -> i8
  %2 = llvm.or %arg1, %arg0 : i8
  %3 = llvm.lshr %2, %0 : i8
  %4 = llvm.or %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
theorem lshr_xor_or_good_mask_proof : lshr_xor_or_good_mask_before ⊑ lshr_xor_or_good_mask_after := by
  unfold lshr_xor_or_good_mask_before lshr_xor_or_good_mask_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN lshr_xor_or_good_mask
  apply lshr_xor_or_good_mask_thm
  ---END lshr_xor_or_good_mask



def shl_xor_xor_good_mask_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 88 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = llvm.shl %arg1, %0 : i8
  %4 = llvm.xor %3, %1 : i8
  %5 = llvm.xor %2, %4 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def shl_xor_xor_good_mask_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 88 : i8}> : () -> i8
  %2 = llvm.xor %arg1, %arg0 : i8
  %3 = llvm.shl %2, %0 : i8
  %4 = llvm.xor %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
theorem shl_xor_xor_good_mask_proof : shl_xor_xor_good_mask_before ⊑ shl_xor_xor_good_mask_after := by
  unfold shl_xor_xor_good_mask_before shl_xor_xor_good_mask_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN shl_xor_xor_good_mask
  all_goals (try extract_goal ; sorry)
  ---END shl_xor_xor_good_mask



def shl_xor_xor_bad_mask_distribute_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = -68 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = llvm.shl %arg1, %0 : i8
  %4 = llvm.xor %3, %1 : i8
  %5 = llvm.xor %2, %4 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def shl_xor_xor_bad_mask_distribute_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = -68 : i8}> : () -> i8
  %2 = llvm.xor %arg1, %arg0 : i8
  %3 = llvm.shl %2, %0 : i8
  %4 = llvm.xor %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
theorem shl_xor_xor_bad_mask_distribute_proof : shl_xor_xor_bad_mask_distribute_before ⊑ shl_xor_xor_bad_mask_distribute_after := by
  unfold shl_xor_xor_bad_mask_distribute_before shl_xor_xor_bad_mask_distribute_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN shl_xor_xor_bad_mask_distribute
  all_goals (try extract_goal ; sorry)
  ---END shl_xor_xor_bad_mask_distribute



def shl_add_and_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 123 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = llvm.shl %arg1, %0 : i8
  %4 = llvm.add %3, %1 : i8
  %5 = llvm.and %2, %4 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def shl_add_and_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 61 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %2 = llvm.add %arg1, %0 : i8
  %3 = llvm.and %2, %arg0 : i8
  %4 = llvm.shl %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
theorem shl_add_and_proof : shl_add_and_before ⊑ shl_add_and_after := by
  unfold shl_add_and_before shl_add_and_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN shl_add_and
  apply shl_add_and_thm
  ---END shl_add_and



def and_ashr_not_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = llvm.ashr %arg0, %arg2 : i8
  %2 = llvm.ashr %arg1, %arg2 : i8
  %3 = llvm.xor %2, %0 : i8
  %4 = llvm.and %1, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def and_ashr_not_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = llvm.xor %arg1, %0 : i8
  %2 = llvm.and %1, %arg0 : i8
  %3 = llvm.ashr %2, %arg2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem and_ashr_not_proof : and_ashr_not_before ⊑ and_ashr_not_after := by
  unfold and_ashr_not_before and_ashr_not_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN and_ashr_not
  apply and_ashr_not_thm
  ---END and_ashr_not



def and_ashr_not_commuted_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = llvm.ashr %arg0, %arg2 : i8
  %2 = llvm.ashr %arg1, %arg2 : i8
  %3 = llvm.xor %2, %0 : i8
  %4 = llvm.and %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def and_ashr_not_commuted_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = llvm.xor %arg1, %0 : i8
  %2 = llvm.and %1, %arg0 : i8
  %3 = llvm.ashr %2, %arg2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem and_ashr_not_commuted_proof : and_ashr_not_commuted_before ⊑ and_ashr_not_commuted_after := by
  unfold and_ashr_not_commuted_before and_ashr_not_commuted_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN and_ashr_not_commuted
  apply and_ashr_not_commuted_thm
  ---END and_ashr_not_commuted



def or_ashr_not_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = llvm.ashr %arg0, %arg2 : i8
  %2 = llvm.ashr %arg1, %arg2 : i8
  %3 = llvm.xor %2, %0 : i8
  %4 = llvm.or %1, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def or_ashr_not_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = llvm.xor %arg1, %0 : i8
  %2 = llvm.or %1, %arg0 : i8
  %3 = llvm.ashr %2, %arg2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem or_ashr_not_proof : or_ashr_not_before ⊑ or_ashr_not_after := by
  unfold or_ashr_not_before or_ashr_not_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_ashr_not
  apply or_ashr_not_thm
  ---END or_ashr_not



def or_ashr_not_commuted_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = llvm.ashr %arg0, %arg2 : i8
  %2 = llvm.ashr %arg1, %arg2 : i8
  %3 = llvm.xor %2, %0 : i8
  %4 = llvm.or %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def or_ashr_not_commuted_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = llvm.xor %arg1, %0 : i8
  %2 = llvm.or %1, %arg0 : i8
  %3 = llvm.ashr %2, %arg2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem or_ashr_not_commuted_proof : or_ashr_not_commuted_before ⊑ or_ashr_not_commuted_after := by
  unfold or_ashr_not_commuted_before or_ashr_not_commuted_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_ashr_not_commuted
  apply or_ashr_not_commuted_thm
  ---END or_ashr_not_commuted



def xor_ashr_not_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = llvm.ashr %arg0, %arg2 : i8
  %2 = llvm.ashr %arg1, %arg2 : i8
  %3 = llvm.xor %2, %0 : i8
  %4 = llvm.xor %1, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def xor_ashr_not_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = llvm.xor %arg1, %arg0 : i8
  %2 = llvm.ashr %1, %arg2 : i8
  %3 = llvm.xor %2, %0 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem xor_ashr_not_proof : xor_ashr_not_before ⊑ xor_ashr_not_after := by
  unfold xor_ashr_not_before xor_ashr_not_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN xor_ashr_not
  apply xor_ashr_not_thm
  ---END xor_ashr_not



def xor_ashr_not_commuted_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = llvm.ashr %arg0, %arg2 : i8
  %2 = llvm.ashr %arg1, %arg2 : i8
  %3 = llvm.xor %2, %0 : i8
  %4 = llvm.xor %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def xor_ashr_not_commuted_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = llvm.xor %arg1, %arg0 : i8
  %2 = llvm.ashr %1, %arg2 : i8
  %3 = llvm.xor %2, %0 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem xor_ashr_not_commuted_proof : xor_ashr_not_commuted_before ⊑ xor_ashr_not_commuted_after := by
  unfold xor_ashr_not_commuted_before xor_ashr_not_commuted_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN xor_ashr_not_commuted
  apply xor_ashr_not_commuted_thm
  ---END xor_ashr_not_commuted



def xor_ashr_not_fail_lshr_ashr_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = llvm.lshr %arg0, %arg2 : i8
  %2 = llvm.ashr %arg1, %arg2 : i8
  %3 = llvm.xor %2, %0 : i8
  %4 = llvm.xor %1, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def xor_ashr_not_fail_lshr_ashr_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = llvm.lshr %arg0, %arg2 : i8
  %2 = llvm.ashr %arg1, %arg2 : i8
  %3 = llvm.xor %2, %1 : i8
  %4 = llvm.xor %3, %0 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
theorem xor_ashr_not_fail_lshr_ashr_proof : xor_ashr_not_fail_lshr_ashr_before ⊑ xor_ashr_not_fail_lshr_ashr_after := by
  unfold xor_ashr_not_fail_lshr_ashr_before xor_ashr_not_fail_lshr_ashr_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN xor_ashr_not_fail_lshr_ashr
  apply xor_ashr_not_fail_lshr_ashr_thm
  ---END xor_ashr_not_fail_lshr_ashr



def xor_ashr_not_fail_ashr_lshr_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = llvm.ashr %arg0, %arg2 : i8
  %2 = llvm.lshr %arg1, %arg2 : i8
  %3 = llvm.xor %2, %0 : i8
  %4 = llvm.xor %1, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def xor_ashr_not_fail_ashr_lshr_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = llvm.ashr %arg0, %arg2 : i8
  %2 = llvm.lshr %arg1, %arg2 : i8
  %3 = llvm.xor %2, %1 : i8
  %4 = llvm.xor %3, %0 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
theorem xor_ashr_not_fail_ashr_lshr_proof : xor_ashr_not_fail_ashr_lshr_before ⊑ xor_ashr_not_fail_ashr_lshr_after := by
  unfold xor_ashr_not_fail_ashr_lshr_before xor_ashr_not_fail_ashr_lshr_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN xor_ashr_not_fail_ashr_lshr
  apply xor_ashr_not_fail_ashr_lshr_thm
  ---END xor_ashr_not_fail_ashr_lshr



def xor_ashr_not_fail_invalid_xor_constant_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{value = -2 : i8}> : () -> i8
  %1 = llvm.ashr %arg0, %arg2 : i8
  %2 = llvm.ashr %arg1, %arg2 : i8
  %3 = llvm.xor %2, %0 : i8
  %4 = llvm.xor %1, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def xor_ashr_not_fail_invalid_xor_constant_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{value = -2 : i8}> : () -> i8
  %1 = llvm.xor %arg1, %arg0 : i8
  %2 = llvm.ashr %1, %arg2 : i8
  %3 = llvm.xor %2, %0 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem xor_ashr_not_fail_invalid_xor_constant_proof : xor_ashr_not_fail_invalid_xor_constant_before ⊑ xor_ashr_not_fail_invalid_xor_constant_after := by
  unfold xor_ashr_not_fail_invalid_xor_constant_before xor_ashr_not_fail_invalid_xor_constant_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN xor_ashr_not_fail_invalid_xor_constant
  apply xor_ashr_not_fail_invalid_xor_constant_thm
  ---END xor_ashr_not_fail_invalid_xor_constant


