import SSA.Projects.InstCombine.tests.LLVM.gandhxorhor_proof
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
                                                                       
def and_xor_not_common_op_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %0 : i32
  %2 = llvm.xor %arg0, %1 : i32
  %3 = llvm.and %2, %arg0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def and_xor_not_common_op_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.and %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem and_xor_not_common_op_proof : and_xor_not_common_op_before ⊑ and_xor_not_common_op_after := by
  unfold and_xor_not_common_op_before and_xor_not_common_op_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN and_xor_not_common_op
  apply and_xor_not_common_op_thm
  ---END and_xor_not_common_op



def and_not_xor_common_op_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %2, %arg0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def and_not_xor_common_op_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.and %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem and_not_xor_common_op_proof : and_not_xor_common_op_before ⊑ and_not_xor_common_op_after := by
  unfold and_not_xor_common_op_before and_not_xor_common_op_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN and_not_xor_common_op
  apply and_not_xor_common_op_thm
  ---END and_not_xor_common_op



def or_before := [llvm|
{
^0(%arg0 : i64, %arg1 : i64):
  %0 = llvm.and %arg1, %arg0 : i64
  %1 = llvm.xor %arg1, %arg0 : i64
  %2 = llvm.add %0, %1 : i64
  "llvm.return"(%2) : (i64) -> ()
}
]
def or_after := [llvm|
{
^0(%arg0 : i64, %arg1 : i64):
  %0 = llvm.or %arg1, %arg0 : i64
  "llvm.return"(%0) : (i64) -> ()
}
]
theorem or_proof : or_before ⊑ or_after := by
  unfold or_before or_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or
  all_goals (try extract_goal ; sorry)
  ---END or



def or2_before := [llvm|
{
^0(%arg0 : i64, %arg1 : i64):
  %0 = llvm.and %arg1, %arg0 : i64
  %1 = llvm.xor %arg1, %arg0 : i64
  %2 = llvm.or %0, %1 : i64
  "llvm.return"(%2) : (i64) -> ()
}
]
def or2_after := [llvm|
{
^0(%arg0 : i64, %arg1 : i64):
  %0 = llvm.or %arg1, %arg0 : i64
  "llvm.return"(%0) : (i64) -> ()
}
]
theorem or2_proof : or2_before ⊑ or2_after := by
  unfold or2_before or2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or2
  all_goals (try extract_goal ; sorry)
  ---END or2



def and_xor_or_negative_before := [llvm|
{
^0(%arg0 : i64, %arg1 : i64, %arg2 : i64, %arg3 : i64):
  %0 = llvm.and %arg1, %arg0 : i64
  %1 = llvm.xor %arg2, %0 : i64
  %2 = llvm.or %arg3, %1 : i64
  "llvm.return"(%2) : (i64) -> ()
}
]
def and_xor_or_negative_after := [llvm|
{
^0(%arg0 : i64, %arg1 : i64, %arg2 : i64, %arg3 : i64):
  %0 = llvm.and %arg1, %arg0 : i64
  %1 = llvm.xor %0, %arg2 : i64
  %2 = llvm.or %1, %arg3 : i64
  "llvm.return"(%2) : (i64) -> ()
}
]
theorem and_xor_or_negative_proof : and_xor_or_negative_before ⊑ and_xor_or_negative_after := by
  unfold and_xor_or_negative_before and_xor_or_negative_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN and_xor_or_negative
  all_goals (try extract_goal ; sorry)
  ---END and_xor_or_negative



def and_shl_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8, %arg3 : i8):
  %0 = llvm.shl %arg0, %arg3 : i8
  %1 = llvm.shl %arg1, %arg3 : i8
  %2 = llvm.and %0, %arg2 : i8
  %3 = llvm.and %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def and_shl_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8, %arg3 : i8):
  %0 = llvm.and %arg0, %arg1 : i8
  %1 = llvm.shl %0, %arg3 : i8
  %2 = llvm.and %1, %arg2 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem and_shl_proof : and_shl_before ⊑ and_shl_after := by
  unfold and_shl_before and_shl_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN and_shl
  apply and_shl_thm
  ---END and_shl



def or_shl_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8, %arg3 : i8):
  %0 = llvm.shl %arg0, %arg3 : i8
  %1 = llvm.shl %arg1, %arg3 : i8
  %2 = llvm.or %0, %arg2 : i8
  %3 = llvm.or %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def or_shl_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8, %arg3 : i8):
  %0 = llvm.or %arg0, %arg1 : i8
  %1 = llvm.shl %0, %arg3 : i8
  %2 = llvm.or %1, %arg2 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem or_shl_proof : or_shl_before ⊑ or_shl_after := by
  unfold or_shl_before or_shl_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_shl
  apply or_shl_thm
  ---END or_shl



def or_lshr_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8, %arg3 : i8):
  %0 = llvm.lshr %arg0, %arg3 : i8
  %1 = llvm.lshr %arg1, %arg3 : i8
  %2 = llvm.or %0, %arg2 : i8
  %3 = llvm.or %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def or_lshr_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8, %arg3 : i8):
  %0 = llvm.or %arg0, %arg1 : i8
  %1 = llvm.lshr %0, %arg3 : i8
  %2 = llvm.or %1, %arg2 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem or_lshr_proof : or_lshr_before ⊑ or_lshr_after := by
  unfold or_lshr_before or_lshr_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_lshr
  apply or_lshr_thm
  ---END or_lshr



def xor_lshr_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8, %arg3 : i8):
  %0 = llvm.lshr %arg0, %arg3 : i8
  %1 = llvm.lshr %arg1, %arg3 : i8
  %2 = llvm.xor %0, %arg2 : i8
  %3 = llvm.xor %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def xor_lshr_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8, %arg3 : i8):
  %0 = llvm.xor %arg0, %arg1 : i8
  %1 = llvm.lshr %0, %arg3 : i8
  %2 = llvm.xor %1, %arg2 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem xor_lshr_proof : xor_lshr_before ⊑ xor_lshr_after := by
  unfold xor_lshr_before xor_lshr_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN xor_lshr
  apply xor_lshr_thm
  ---END xor_lshr



def xor_lshr_multiuse_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8, %arg3 : i8):
  %0 = llvm.lshr %arg0, %arg3 : i8
  %1 = llvm.lshr %arg1, %arg3 : i8
  %2 = llvm.xor %0, %arg2 : i8
  %3 = llvm.xor %2, %1 : i8
  %4 = llvm.sdiv %2, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def xor_lshr_multiuse_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8, %arg3 : i8):
  %0 = llvm.lshr %arg0, %arg3 : i8
  %1 = llvm.xor %0, %arg2 : i8
  %2 = llvm.xor %arg0, %arg1 : i8
  %3 = llvm.lshr %2, %arg3 : i8
  %4 = llvm.xor %3, %arg2 : i8
  %5 = llvm.sdiv %1, %4 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
theorem xor_lshr_multiuse_proof : xor_lshr_multiuse_before ⊑ xor_lshr_multiuse_after := by
  unfold xor_lshr_multiuse_before xor_lshr_multiuse_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN xor_lshr_multiuse
  all_goals (try extract_goal ; sorry)
  ---END xor_lshr_multiuse



def not_and_and_not_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg0 : i32
  %3 = llvm.xor %arg1, %1 : i32
  %4 = llvm.xor %arg2, %1 : i32
  %5 = llvm.and %2, %3 : i32
  %6 = llvm.and %5, %4 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def not_and_and_not_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg0 : i32
  %3 = llvm.or %arg1, %arg2 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.and %2, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
theorem not_and_and_not_proof : not_and_and_not_before ⊑ not_and_and_not_after := by
  unfold not_and_and_not_before not_and_and_not_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN not_and_and_not
  apply not_and_and_not_thm
  ---END not_and_and_not



def not_and_and_not_commute1_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %0 : i32
  %2 = llvm.xor %arg2, %0 : i32
  %3 = llvm.and %1, %arg0 : i32
  %4 = llvm.and %3, %2 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def not_and_and_not_commute1_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.or %arg1, %arg2 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %2, %arg0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem not_and_and_not_commute1_proof : not_and_and_not_commute1_before ⊑ not_and_and_not_commute1_after := by
  unfold not_and_and_not_commute1_before not_and_and_not_commute1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN not_and_and_not_commute1
  apply not_and_and_not_commute1_thm
  ---END not_and_and_not_commute1



def not_or_or_not_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg0 : i32
  %3 = llvm.xor %arg1, %1 : i32
  %4 = llvm.xor %arg2, %1 : i32
  %5 = llvm.or %2, %3 : i32
  %6 = llvm.or %5, %4 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def not_or_or_not_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg0 : i32
  %3 = llvm.and %arg1, %arg2 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.or %2, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
theorem not_or_or_not_proof : not_or_or_not_before ⊑ not_or_or_not_after := by
  unfold not_or_or_not_before not_or_or_not_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN not_or_or_not
  apply not_or_or_not_thm
  ---END not_or_or_not



def not_or_or_not_commute1_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %0 : i32
  %2 = llvm.xor %arg2, %0 : i32
  %3 = llvm.or %1, %arg0 : i32
  %4 = llvm.or %3, %2 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def not_or_or_not_commute1_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg1, %arg2 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %2, %arg0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem not_or_or_not_commute1_proof : not_or_or_not_commute1_before ⊑ not_or_or_not_commute1_after := by
  unfold not_or_or_not_commute1_before not_or_or_not_commute1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN not_or_or_not_commute1
  apply not_or_or_not_commute1_thm
  ---END not_or_or_not_commute1



def or_not_and_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.or %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %2, %arg2 : i32
  %4 = llvm.or %arg0, %arg2 : i32
  %5 = llvm.xor %4, %0 : i32
  %6 = llvm.and %5, %arg1 : i32
  %7 = llvm.or %3, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def or_not_and_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %arg2 : i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.and %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem or_not_and_proof : or_not_and_before ⊑ or_not_and_after := by
  unfold or_not_and_before or_not_and_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_not_and
  apply or_not_and_thm
  ---END or_not_and



def or_not_and_commute1_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg1 : i32
  %3 = llvm.or %arg0, %2 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.and %4, %arg2 : i32
  %6 = llvm.or %arg0, %arg2 : i32
  %7 = llvm.xor %6, %1 : i32
  %8 = llvm.and %2, %7 : i32
  %9 = llvm.or %5, %8 : i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def or_not_and_commute1_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg1 : i32
  %3 = llvm.xor %2, %arg2 : i32
  %4 = llvm.xor %arg0, %1 : i32
  %5 = llvm.and %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
theorem or_not_and_commute1_proof : or_not_and_commute1_before ⊑ or_not_and_commute1_after := by
  unfold or_not_and_commute1_before or_not_and_commute1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_not_and_commute1
  apply or_not_and_commute1_thm
  ---END or_not_and_commute1



def or_not_and_commute2_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg1 : i32
  %3 = llvm.or %arg0, %2 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.and %4, %arg2 : i32
  %6 = llvm.or %arg0, %arg2 : i32
  %7 = llvm.xor %6, %1 : i32
  %8 = llvm.and %2, %7 : i32
  %9 = llvm.or %8, %5 : i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def or_not_and_commute2_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg1 : i32
  %3 = llvm.xor %2, %arg2 : i32
  %4 = llvm.xor %arg0, %1 : i32
  %5 = llvm.and %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
theorem or_not_and_commute2_proof : or_not_and_commute2_before ⊑ or_not_and_commute2_after := by
  unfold or_not_and_commute2_before or_not_and_commute2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_not_and_commute2
  apply or_not_and_commute2_thm
  ---END or_not_and_commute2



def or_not_and_commute3_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.or %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %2, %arg2 : i32
  %4 = llvm.or %arg2, %arg0 : i32
  %5 = llvm.xor %4, %0 : i32
  %6 = llvm.and %5, %arg1 : i32
  %7 = llvm.or %3, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def or_not_and_commute3_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %arg2 : i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.and %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem or_not_and_commute3_proof : or_not_and_commute3_before ⊑ or_not_and_commute3_after := by
  unfold or_not_and_commute3_before or_not_and_commute3_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_not_and_commute3
  apply or_not_and_commute3_thm
  ---END or_not_and_commute3



def or_not_and_commute4_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg2 : i32
  %3 = llvm.or %arg0, %arg1 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.and %2, %4 : i32
  %6 = llvm.or %arg0, %2 : i32
  %7 = llvm.xor %6, %1 : i32
  %8 = llvm.and %7, %arg1 : i32
  %9 = llvm.or %5, %8 : i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def or_not_and_commute4_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg2 : i32
  %3 = llvm.xor %2, %arg1 : i32
  %4 = llvm.xor %arg0, %1 : i32
  %5 = llvm.and %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
theorem or_not_and_commute4_proof : or_not_and_commute4_before ⊑ or_not_and_commute4_after := by
  unfold or_not_and_commute4_before or_not_and_commute4_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_not_and_commute4
  apply or_not_and_commute4_thm
  ---END or_not_and_commute4



def or_not_and_commute5_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg0 : i32
  %3 = llvm.sdiv %0, %arg2 : i32
  %4 = llvm.or %2, %arg1 : i32
  %5 = llvm.xor %4, %1 : i32
  %6 = llvm.and %3, %5 : i32
  %7 = llvm.or %2, %3 : i32
  %8 = llvm.xor %7, %1 : i32
  %9 = llvm.and %8, %arg1 : i32
  %10 = llvm.or %6, %9 : i32
  "llvm.return"(%10) : (i32) -> ()
}
]
def or_not_and_commute5_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg0 : i32
  %3 = llvm.sdiv %0, %arg2 : i32
  %4 = llvm.xor %3, %arg1 : i32
  %5 = llvm.xor %2, %1 : i32
  %6 = llvm.and %4, %5 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
theorem or_not_and_commute5_proof : or_not_and_commute5_before ⊑ or_not_and_commute5_after := by
  unfold or_not_and_commute5_before or_not_and_commute5_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_not_and_commute5
  apply or_not_and_commute5_thm
  ---END or_not_and_commute5



def or_not_and_commute6_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.or %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %2, %arg2 : i32
  %4 = llvm.or %arg2, %arg0 : i32
  %5 = llvm.xor %4, %0 : i32
  %6 = llvm.and %5, %arg1 : i32
  %7 = llvm.or %3, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def or_not_and_commute6_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %arg2 : i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.and %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem or_not_and_commute6_proof : or_not_and_commute6_before ⊑ or_not_and_commute6_after := by
  unfold or_not_and_commute6_before or_not_and_commute6_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_not_and_commute6
  apply or_not_and_commute6_thm
  ---END or_not_and_commute6



def or_not_and_commute7_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.or %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %2, %arg2 : i32
  %4 = llvm.or %arg0, %arg2 : i32
  %5 = llvm.xor %4, %0 : i32
  %6 = llvm.and %5, %arg1 : i32
  %7 = llvm.or %3, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def or_not_and_commute7_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %arg2 : i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.and %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem or_not_and_commute7_proof : or_not_and_commute7_before ⊑ or_not_and_commute7_after := by
  unfold or_not_and_commute7_before or_not_and_commute7_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_not_and_commute7
  apply or_not_and_commute7_thm
  ---END or_not_and_commute7



def or_not_and_commute8_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg0 : i32
  %3 = llvm.sdiv %0, %arg1 : i32
  %4 = llvm.or %2, %3 : i32
  %5 = llvm.xor %4, %1 : i32
  %6 = llvm.and %5, %arg2 : i32
  %7 = llvm.or %arg2, %2 : i32
  %8 = llvm.xor %7, %1 : i32
  %9 = llvm.and %3, %8 : i32
  %10 = llvm.or %6, %9 : i32
  "llvm.return"(%10) : (i32) -> ()
}
]
def or_not_and_commute8_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg0 : i32
  %3 = llvm.sdiv %0, %arg1 : i32
  %4 = llvm.xor %3, %arg2 : i32
  %5 = llvm.xor %2, %1 : i32
  %6 = llvm.and %4, %5 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
theorem or_not_and_commute8_proof : or_not_and_commute8_before ⊑ or_not_and_commute8_after := by
  unfold or_not_and_commute8_before or_not_and_commute8_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_not_and_commute8
  apply or_not_and_commute8_thm
  ---END or_not_and_commute8



def or_not_and_commute9_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg0 : i32
  %3 = llvm.sdiv %0, %arg1 : i32
  %4 = llvm.sdiv %0, %arg2 : i32
  %5 = llvm.or %2, %3 : i32
  %6 = llvm.xor %5, %1 : i32
  %7 = llvm.and %6, %4 : i32
  %8 = llvm.or %2, %4 : i32
  %9 = llvm.xor %8, %1 : i32
  %10 = llvm.and %3, %9 : i32
  %11 = llvm.or %7, %10 : i32
  "llvm.return"(%11) : (i32) -> ()
}
]
def or_not_and_commute9_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg0 : i32
  %3 = llvm.sdiv %0, %arg1 : i32
  %4 = llvm.sdiv %0, %arg2 : i32
  %5 = llvm.xor %3, %4 : i32
  %6 = llvm.xor %2, %1 : i32
  %7 = llvm.and %5, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
theorem or_not_and_commute9_proof : or_not_and_commute9_before ⊑ or_not_and_commute9_after := by
  unfold or_not_and_commute9_before or_not_and_commute9_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_not_and_commute9
  apply or_not_and_commute9_thm
  ---END or_not_and_commute9



def and_not_or_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %2, %arg2 : i32
  %4 = llvm.and %arg0, %arg2 : i32
  %5 = llvm.xor %4, %0 : i32
  %6 = llvm.or %5, %arg1 : i32
  %7 = llvm.and %3, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def and_not_or_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %arg2 : i32
  %2 = llvm.and %1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem and_not_or_proof : and_not_or_before ⊑ and_not_or_after := by
  unfold and_not_or_before and_not_or_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN and_not_or
  apply and_not_or_thm
  ---END and_not_or



def and_not_or_commute1_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg1 : i32
  %3 = llvm.and %arg0, %2 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.or %4, %arg2 : i32
  %6 = llvm.and %arg0, %arg2 : i32
  %7 = llvm.xor %6, %1 : i32
  %8 = llvm.or %2, %7 : i32
  %9 = llvm.and %5, %8 : i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def and_not_or_commute1_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg1 : i32
  %3 = llvm.xor %2, %arg2 : i32
  %4 = llvm.and %3, %arg0 : i32
  %5 = llvm.xor %4, %1 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
theorem and_not_or_commute1_proof : and_not_or_commute1_before ⊑ and_not_or_commute1_after := by
  unfold and_not_or_commute1_before and_not_or_commute1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN and_not_or_commute1
  apply and_not_or_commute1_thm
  ---END and_not_or_commute1



def and_not_or_commute2_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg1 : i32
  %3 = llvm.and %arg0, %2 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.or %4, %arg2 : i32
  %6 = llvm.and %arg0, %arg2 : i32
  %7 = llvm.xor %6, %1 : i32
  %8 = llvm.or %2, %7 : i32
  %9 = llvm.and %8, %5 : i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def and_not_or_commute2_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg1 : i32
  %3 = llvm.xor %2, %arg2 : i32
  %4 = llvm.and %3, %arg0 : i32
  %5 = llvm.xor %4, %1 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
theorem and_not_or_commute2_proof : and_not_or_commute2_before ⊑ and_not_or_commute2_after := by
  unfold and_not_or_commute2_before and_not_or_commute2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN and_not_or_commute2
  apply and_not_or_commute2_thm
  ---END and_not_or_commute2



def and_not_or_commute3_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %2, %arg2 : i32
  %4 = llvm.and %arg2, %arg0 : i32
  %5 = llvm.xor %4, %0 : i32
  %6 = llvm.or %5, %arg1 : i32
  %7 = llvm.and %3, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def and_not_or_commute3_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %arg2 : i32
  %2 = llvm.and %1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem and_not_or_commute3_proof : and_not_or_commute3_before ⊑ and_not_or_commute3_after := by
  unfold and_not_or_commute3_before and_not_or_commute3_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN and_not_or_commute3
  apply and_not_or_commute3_thm
  ---END and_not_or_commute3



def and_not_or_commute4_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg2 : i32
  %3 = llvm.and %arg0, %arg1 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.or %2, %4 : i32
  %6 = llvm.and %arg0, %2 : i32
  %7 = llvm.xor %6, %1 : i32
  %8 = llvm.or %7, %arg1 : i32
  %9 = llvm.and %5, %8 : i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def and_not_or_commute4_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg2 : i32
  %3 = llvm.xor %2, %arg1 : i32
  %4 = llvm.and %3, %arg0 : i32
  %5 = llvm.xor %4, %1 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
theorem and_not_or_commute4_proof : and_not_or_commute4_before ⊑ and_not_or_commute4_after := by
  unfold and_not_or_commute4_before and_not_or_commute4_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN and_not_or_commute4
  apply and_not_or_commute4_thm
  ---END and_not_or_commute4



def and_not_or_commute5_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg0 : i32
  %3 = llvm.sdiv %0, %arg2 : i32
  %4 = llvm.and %2, %arg1 : i32
  %5 = llvm.xor %4, %1 : i32
  %6 = llvm.or %3, %5 : i32
  %7 = llvm.and %2, %3 : i32
  %8 = llvm.xor %7, %1 : i32
  %9 = llvm.or %8, %arg1 : i32
  %10 = llvm.and %6, %9 : i32
  "llvm.return"(%10) : (i32) -> ()
}
]
def and_not_or_commute5_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg0 : i32
  %3 = llvm.sdiv %0, %arg2 : i32
  %4 = llvm.xor %3, %arg1 : i32
  %5 = llvm.and %4, %2 : i32
  %6 = llvm.xor %5, %1 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
theorem and_not_or_commute5_proof : and_not_or_commute5_before ⊑ and_not_or_commute5_after := by
  unfold and_not_or_commute5_before and_not_or_commute5_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN and_not_or_commute5
  apply and_not_or_commute5_thm
  ---END and_not_or_commute5



def and_not_or_commute6_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %2, %arg2 : i32
  %4 = llvm.and %arg2, %arg0 : i32
  %5 = llvm.xor %4, %0 : i32
  %6 = llvm.or %5, %arg1 : i32
  %7 = llvm.and %3, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def and_not_or_commute6_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %arg2 : i32
  %2 = llvm.and %1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem and_not_or_commute6_proof : and_not_or_commute6_before ⊑ and_not_or_commute6_after := by
  unfold and_not_or_commute6_before and_not_or_commute6_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN and_not_or_commute6
  apply and_not_or_commute6_thm
  ---END and_not_or_commute6



def and_not_or_commute7_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %2, %arg2 : i32
  %4 = llvm.and %arg0, %arg2 : i32
  %5 = llvm.xor %4, %0 : i32
  %6 = llvm.or %5, %arg1 : i32
  %7 = llvm.and %3, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def and_not_or_commute7_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %arg2 : i32
  %2 = llvm.and %1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem and_not_or_commute7_proof : and_not_or_commute7_before ⊑ and_not_or_commute7_after := by
  unfold and_not_or_commute7_before and_not_or_commute7_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN and_not_or_commute7
  apply and_not_or_commute7_thm
  ---END and_not_or_commute7



def and_not_or_commute8_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg0 : i32
  %3 = llvm.sdiv %0, %arg1 : i32
  %4 = llvm.and %2, %3 : i32
  %5 = llvm.xor %4, %1 : i32
  %6 = llvm.or %5, %arg2 : i32
  %7 = llvm.and %arg2, %2 : i32
  %8 = llvm.xor %7, %1 : i32
  %9 = llvm.or %3, %8 : i32
  %10 = llvm.and %6, %9 : i32
  "llvm.return"(%10) : (i32) -> ()
}
]
def and_not_or_commute8_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg0 : i32
  %3 = llvm.sdiv %0, %arg1 : i32
  %4 = llvm.xor %3, %arg2 : i32
  %5 = llvm.and %4, %2 : i32
  %6 = llvm.xor %5, %1 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
theorem and_not_or_commute8_proof : and_not_or_commute8_before ⊑ and_not_or_commute8_after := by
  unfold and_not_or_commute8_before and_not_or_commute8_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN and_not_or_commute8
  apply and_not_or_commute8_thm
  ---END and_not_or_commute8



def and_not_or_commute9_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg0 : i32
  %3 = llvm.sdiv %0, %arg1 : i32
  %4 = llvm.sdiv %0, %arg2 : i32
  %5 = llvm.and %2, %3 : i32
  %6 = llvm.xor %5, %1 : i32
  %7 = llvm.or %6, %4 : i32
  %8 = llvm.and %2, %4 : i32
  %9 = llvm.xor %8, %1 : i32
  %10 = llvm.or %3, %9 : i32
  %11 = llvm.and %7, %10 : i32
  "llvm.return"(%11) : (i32) -> ()
}
]
def and_not_or_commute9_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg0 : i32
  %3 = llvm.sdiv %0, %arg1 : i32
  %4 = llvm.sdiv %0, %arg2 : i32
  %5 = llvm.xor %3, %4 : i32
  %6 = llvm.and %5, %2 : i32
  %7 = llvm.xor %6, %1 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
theorem and_not_or_commute9_proof : and_not_or_commute9_before ⊑ and_not_or_commute9_after := by
  unfold and_not_or_commute9_before and_not_or_commute9_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN and_not_or_commute9
  apply and_not_or_commute9_thm
  ---END and_not_or_commute9



def or_and_not_not_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.or %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %arg0, %arg2 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.and %4, %arg1 : i32
  %6 = llvm.or %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def or_and_not_not_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg2, %arg1 : i32
  %2 = llvm.or %1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem or_and_not_not_proof : or_and_not_not_before ⊑ or_and_not_not_after := by
  unfold or_and_not_not_before or_and_not_not_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_and_not_not
  apply or_and_not_not_thm
  ---END or_and_not_not



def or_and_not_not_commute1_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg1 : i32
  %3 = llvm.or %2, %arg0 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.or %arg0, %arg2 : i32
  %6 = llvm.xor %5, %1 : i32
  %7 = llvm.and %2, %6 : i32
  %8 = llvm.or %7, %4 : i32
  "llvm.return"(%8) : (i32) -> ()
}
]
def or_and_not_not_commute1_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg1 : i32
  %3 = llvm.and %2, %arg2 : i32
  %4 = llvm.or %3, %arg0 : i32
  %5 = llvm.xor %4, %1 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
theorem or_and_not_not_commute1_proof : or_and_not_not_commute1_before ⊑ or_and_not_not_commute1_after := by
  unfold or_and_not_not_commute1_before or_and_not_not_commute1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_and_not_not_commute1
  apply or_and_not_not_commute1_thm
  ---END or_and_not_not_commute1



def or_and_not_not_commute2_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.or %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %arg0, %arg2 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.and %4, %arg1 : i32
  %6 = llvm.or %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def or_and_not_not_commute2_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg2, %arg1 : i32
  %2 = llvm.or %1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem or_and_not_not_commute2_proof : or_and_not_not_commute2_before ⊑ or_and_not_not_commute2_after := by
  unfold or_and_not_not_commute2_before or_and_not_not_commute2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_and_not_not_commute2
  apply or_and_not_not_commute2_thm
  ---END or_and_not_not_commute2



def or_and_not_not_commute3_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.or %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %arg2, %arg0 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.and %4, %arg1 : i32
  %6 = llvm.or %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def or_and_not_not_commute3_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg2, %arg1 : i32
  %2 = llvm.or %1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem or_and_not_not_commute3_proof : or_and_not_not_commute3_before ⊑ or_and_not_not_commute3_after := by
  unfold or_and_not_not_commute3_before or_and_not_not_commute3_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_and_not_not_commute3
  apply or_and_not_not_commute3_thm
  ---END or_and_not_not_commute3



def or_and_not_not_commute4_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.or %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %arg0, %arg2 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.and %4, %arg1 : i32
  %6 = llvm.or %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def or_and_not_not_commute4_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg2, %arg1 : i32
  %2 = llvm.or %1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem or_and_not_not_commute4_proof : or_and_not_not_commute4_before ⊑ or_and_not_not_commute4_after := by
  unfold or_and_not_not_commute4_before or_and_not_not_commute4_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_and_not_not_commute4
  apply or_and_not_not_commute4_thm
  ---END or_and_not_not_commute4



def or_and_not_not_commute5_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.or %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %arg0, %arg2 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.and %4, %arg1 : i32
  %6 = llvm.or %2, %5 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def or_and_not_not_commute5_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg2, %arg1 : i32
  %2 = llvm.or %1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem or_and_not_not_commute5_proof : or_and_not_not_commute5_before ⊑ or_and_not_not_commute5_after := by
  unfold or_and_not_not_commute5_before or_and_not_not_commute5_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_and_not_not_commute5
  apply or_and_not_not_commute5_thm
  ---END or_and_not_not_commute5



def or_and_not_not_commute6_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg1 : i32
  %3 = llvm.or %2, %arg0 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.or %arg2, %arg0 : i32
  %6 = llvm.xor %5, %1 : i32
  %7 = llvm.and %2, %6 : i32
  %8 = llvm.or %7, %4 : i32
  "llvm.return"(%8) : (i32) -> ()
}
]
def or_and_not_not_commute6_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg1 : i32
  %3 = llvm.and %2, %arg2 : i32
  %4 = llvm.or %3, %arg0 : i32
  %5 = llvm.xor %4, %1 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
theorem or_and_not_not_commute6_proof : or_and_not_not_commute6_before ⊑ or_and_not_not_commute6_after := by
  unfold or_and_not_not_commute6_before or_and_not_not_commute6_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_and_not_not_commute6
  apply or_and_not_not_commute6_thm
  ---END or_and_not_not_commute6



def or_and_not_not_commute7_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.or %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %arg2, %arg0 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.and %4, %arg1 : i32
  %6 = llvm.or %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def or_and_not_not_commute7_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg2, %arg1 : i32
  %2 = llvm.or %1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem or_and_not_not_commute7_proof : or_and_not_not_commute7_before ⊑ or_and_not_not_commute7_after := by
  unfold or_and_not_not_commute7_before or_and_not_not_commute7_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_and_not_not_commute7
  apply or_and_not_not_commute7_thm
  ---END or_and_not_not_commute7



def and_or_not_not_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %arg0, %arg2 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.or %4, %arg1 : i32
  %6 = llvm.and %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def and_or_not_not_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.or %arg2, %arg1 : i32
  %2 = llvm.and %1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem and_or_not_not_proof : and_or_not_not_before ⊑ and_or_not_not_after := by
  unfold and_or_not_not_before and_or_not_not_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN and_or_not_not
  apply and_or_not_not_thm
  ---END and_or_not_not



def and_or_not_not_commute1_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg1 : i32
  %3 = llvm.and %2, %arg0 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.and %arg0, %arg2 : i32
  %6 = llvm.xor %5, %1 : i32
  %7 = llvm.or %2, %6 : i32
  %8 = llvm.and %7, %4 : i32
  "llvm.return"(%8) : (i32) -> ()
}
]
def and_or_not_not_commute1_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg1 : i32
  %3 = llvm.or %2, %arg2 : i32
  %4 = llvm.and %3, %arg0 : i32
  %5 = llvm.xor %4, %1 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
theorem and_or_not_not_commute1_proof : and_or_not_not_commute1_before ⊑ and_or_not_not_commute1_after := by
  unfold and_or_not_not_commute1_before and_or_not_not_commute1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN and_or_not_not_commute1
  apply and_or_not_not_commute1_thm
  ---END and_or_not_not_commute1



def and_or_not_not_commute2_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %arg0, %arg2 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.or %4, %arg1 : i32
  %6 = llvm.and %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def and_or_not_not_commute2_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.or %arg2, %arg1 : i32
  %2 = llvm.and %1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem and_or_not_not_commute2_proof : and_or_not_not_commute2_before ⊑ and_or_not_not_commute2_after := by
  unfold and_or_not_not_commute2_before and_or_not_not_commute2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN and_or_not_not_commute2
  apply and_or_not_not_commute2_thm
  ---END and_or_not_not_commute2



def and_or_not_not_commute3_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %arg2, %arg0 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.or %4, %arg1 : i32
  %6 = llvm.and %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def and_or_not_not_commute3_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.or %arg2, %arg1 : i32
  %2 = llvm.and %1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem and_or_not_not_commute3_proof : and_or_not_not_commute3_before ⊑ and_or_not_not_commute3_after := by
  unfold and_or_not_not_commute3_before and_or_not_not_commute3_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN and_or_not_not_commute3
  apply and_or_not_not_commute3_thm
  ---END and_or_not_not_commute3



def and_or_not_not_commute4_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %arg0, %arg2 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.or %4, %arg1 : i32
  %6 = llvm.and %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def and_or_not_not_commute4_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.or %arg2, %arg1 : i32
  %2 = llvm.and %1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem and_or_not_not_commute4_proof : and_or_not_not_commute4_before ⊑ and_or_not_not_commute4_after := by
  unfold and_or_not_not_commute4_before and_or_not_not_commute4_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN and_or_not_not_commute4
  apply and_or_not_not_commute4_thm
  ---END and_or_not_not_commute4



def and_or_not_not_commute5_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %arg0, %arg2 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.or %4, %arg1 : i32
  %6 = llvm.and %2, %5 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def and_or_not_not_commute5_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.or %arg2, %arg1 : i32
  %2 = llvm.and %1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem and_or_not_not_commute5_proof : and_or_not_not_commute5_before ⊑ and_or_not_not_commute5_after := by
  unfold and_or_not_not_commute5_before and_or_not_not_commute5_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN and_or_not_not_commute5
  apply and_or_not_not_commute5_thm
  ---END and_or_not_not_commute5



def and_or_not_not_commute6_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg1 : i32
  %3 = llvm.and %2, %arg0 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.and %arg2, %arg0 : i32
  %6 = llvm.xor %5, %1 : i32
  %7 = llvm.or %2, %6 : i32
  %8 = llvm.and %7, %4 : i32
  "llvm.return"(%8) : (i32) -> ()
}
]
def and_or_not_not_commute6_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg1 : i32
  %3 = llvm.or %2, %arg2 : i32
  %4 = llvm.and %3, %arg0 : i32
  %5 = llvm.xor %4, %1 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
theorem and_or_not_not_commute6_proof : and_or_not_not_commute6_before ⊑ and_or_not_not_commute6_after := by
  unfold and_or_not_not_commute6_before and_or_not_not_commute6_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN and_or_not_not_commute6
  apply and_or_not_not_commute6_thm
  ---END and_or_not_not_commute6



def and_or_not_not_commute7_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %arg2, %arg0 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.or %4, %arg1 : i32
  %6 = llvm.and %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def and_or_not_not_commute7_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.or %arg2, %arg1 : i32
  %2 = llvm.and %1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem and_or_not_not_commute7_proof : and_or_not_not_commute7_before ⊑ and_or_not_not_commute7_after := by
  unfold and_or_not_not_commute7_before and_or_not_not_commute7_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN and_or_not_not_commute7
  apply and_or_not_not_commute7_thm
  ---END and_or_not_not_commute7



def and_or_not_not_wrong_a_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32, %arg3 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg1, %arg3 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %arg0, %arg2 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.or %4, %arg1 : i32
  %6 = llvm.and %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def and_or_not_not_wrong_a_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32, %arg3 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg1, %arg3 : i32
  %2 = llvm.and %arg0, %arg2 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.or %3, %arg1 : i32
  %5 = llvm.xor %1, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
theorem and_or_not_not_wrong_a_proof : and_or_not_not_wrong_a_before ⊑ and_or_not_not_wrong_a_after := by
  unfold and_or_not_not_wrong_a_before and_or_not_not_wrong_a_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN and_or_not_not_wrong_a
  apply and_or_not_not_wrong_a_thm
  ---END and_or_not_not_wrong_a



def and_not_or_or_not_or_xor_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.or %arg1, %arg2 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %2, %arg0 : i32
  %4 = llvm.xor %arg1, %arg2 : i32
  %5 = llvm.or %4, %arg0 : i32
  %6 = llvm.xor %5, %0 : i32
  %7 = llvm.or %3, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def and_not_or_or_not_or_xor_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.or %arg1, %arg2 : i32
  %2 = llvm.xor %arg1, %arg2 : i32
  %3 = llvm.or %2, %arg0 : i32
  %4 = llvm.and %1, %3 : i32
  %5 = llvm.xor %4, %0 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
theorem and_not_or_or_not_or_xor_proof : and_not_or_or_not_or_xor_before ⊑ and_not_or_or_not_or_xor_after := by
  unfold and_not_or_or_not_or_xor_before and_not_or_or_not_or_xor_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN and_not_or_or_not_or_xor
  apply and_not_or_or_not_or_xor_thm
  ---END and_not_or_or_not_or_xor



def and_not_or_or_not_or_xor_commute1_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.or %arg2, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %2, %arg0 : i32
  %4 = llvm.xor %arg1, %arg2 : i32
  %5 = llvm.or %4, %arg0 : i32
  %6 = llvm.xor %5, %0 : i32
  %7 = llvm.or %3, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def and_not_or_or_not_or_xor_commute1_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.or %arg2, %arg1 : i32
  %2 = llvm.xor %arg1, %arg2 : i32
  %3 = llvm.or %2, %arg0 : i32
  %4 = llvm.and %1, %3 : i32
  %5 = llvm.xor %4, %0 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
theorem and_not_or_or_not_or_xor_commute1_proof : and_not_or_or_not_or_xor_commute1_before ⊑ and_not_or_or_not_or_xor_commute1_after := by
  unfold and_not_or_or_not_or_xor_commute1_before and_not_or_or_not_or_xor_commute1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN and_not_or_or_not_or_xor_commute1
  apply and_not_or_or_not_or_xor_commute1_thm
  ---END and_not_or_or_not_or_xor_commute1



def and_not_or_or_not_or_xor_commute2_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg0 : i32
  %3 = llvm.or %arg1, %arg2 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.and %2, %4 : i32
  %6 = llvm.xor %arg1, %arg2 : i32
  %7 = llvm.or %6, %2 : i32
  %8 = llvm.xor %7, %1 : i32
  %9 = llvm.or %5, %8 : i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def and_not_or_or_not_or_xor_commute2_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg0 : i32
  %3 = llvm.or %arg1, %arg2 : i32
  %4 = llvm.xor %arg1, %arg2 : i32
  %5 = llvm.or %4, %2 : i32
  %6 = llvm.and %3, %5 : i32
  %7 = llvm.xor %6, %1 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
theorem and_not_or_or_not_or_xor_commute2_proof : and_not_or_or_not_or_xor_commute2_before ⊑ and_not_or_or_not_or_xor_commute2_after := by
  unfold and_not_or_or_not_or_xor_commute2_before and_not_or_or_not_or_xor_commute2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN and_not_or_or_not_or_xor_commute2
  apply and_not_or_or_not_or_xor_commute2_thm
  ---END and_not_or_or_not_or_xor_commute2



def and_not_or_or_not_or_xor_commute3_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.or %arg1, %arg2 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %2, %arg0 : i32
  %4 = llvm.xor %arg2, %arg1 : i32
  %5 = llvm.or %4, %arg0 : i32
  %6 = llvm.xor %5, %0 : i32
  %7 = llvm.or %3, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def and_not_or_or_not_or_xor_commute3_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.or %arg1, %arg2 : i32
  %2 = llvm.xor %arg2, %arg1 : i32
  %3 = llvm.or %2, %arg0 : i32
  %4 = llvm.and %1, %3 : i32
  %5 = llvm.xor %4, %0 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
theorem and_not_or_or_not_or_xor_commute3_proof : and_not_or_or_not_or_xor_commute3_before ⊑ and_not_or_or_not_or_xor_commute3_after := by
  unfold and_not_or_or_not_or_xor_commute3_before and_not_or_or_not_or_xor_commute3_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN and_not_or_or_not_or_xor_commute3
  apply and_not_or_or_not_or_xor_commute3_thm
  ---END and_not_or_or_not_or_xor_commute3



def and_not_or_or_not_or_xor_commute4_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg0 : i32
  %3 = llvm.or %arg1, %arg2 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.and %2, %4 : i32
  %6 = llvm.xor %arg1, %arg2 : i32
  %7 = llvm.or %2, %6 : i32
  %8 = llvm.xor %7, %1 : i32
  %9 = llvm.or %5, %8 : i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def and_not_or_or_not_or_xor_commute4_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg0 : i32
  %3 = llvm.or %arg1, %arg2 : i32
  %4 = llvm.xor %arg1, %arg2 : i32
  %5 = llvm.or %2, %4 : i32
  %6 = llvm.and %3, %5 : i32
  %7 = llvm.xor %6, %1 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
theorem and_not_or_or_not_or_xor_commute4_proof : and_not_or_or_not_or_xor_commute4_before ⊑ and_not_or_or_not_or_xor_commute4_after := by
  unfold and_not_or_or_not_or_xor_commute4_before and_not_or_or_not_or_xor_commute4_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN and_not_or_or_not_or_xor_commute4
  apply and_not_or_or_not_or_xor_commute4_thm
  ---END and_not_or_or_not_or_xor_commute4



def and_not_or_or_not_or_xor_commute5_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.or %arg1, %arg2 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %2, %arg0 : i32
  %4 = llvm.xor %arg1, %arg2 : i32
  %5 = llvm.or %4, %arg0 : i32
  %6 = llvm.xor %5, %0 : i32
  %7 = llvm.or %6, %3 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def and_not_or_or_not_or_xor_commute5_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.or %arg1, %arg2 : i32
  %2 = llvm.xor %arg1, %arg2 : i32
  %3 = llvm.or %2, %arg0 : i32
  %4 = llvm.and %1, %3 : i32
  %5 = llvm.xor %4, %0 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
theorem and_not_or_or_not_or_xor_commute5_proof : and_not_or_or_not_or_xor_commute5_before ⊑ and_not_or_or_not_or_xor_commute5_after := by
  unfold and_not_or_or_not_or_xor_commute5_before and_not_or_or_not_or_xor_commute5_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN and_not_or_or_not_or_xor_commute5
  apply and_not_or_or_not_or_xor_commute5_thm
  ---END and_not_or_or_not_or_xor_commute5



def or_not_and_and_not_and_xor_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg1, %arg2 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %2, %arg0 : i32
  %4 = llvm.xor %arg1, %arg2 : i32
  %5 = llvm.and %4, %arg0 : i32
  %6 = llvm.xor %5, %0 : i32
  %7 = llvm.and %3, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def or_not_and_and_not_and_xor_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg1, %arg2 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %2, %arg0 : i32
  %4 = llvm.xor %arg1, %arg2 : i32
  %5 = llvm.and %4, %arg0 : i32
  %6 = llvm.xor %5, %3 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
theorem or_not_and_and_not_and_xor_proof : or_not_and_and_not_and_xor_before ⊑ or_not_and_and_not_and_xor_after := by
  unfold or_not_and_and_not_and_xor_before or_not_and_and_not_and_xor_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_not_and_and_not_and_xor
  apply or_not_and_and_not_and_xor_thm
  ---END or_not_and_and_not_and_xor



def or_not_and_and_not_and_xor_commute1_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg2, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %2, %arg0 : i32
  %4 = llvm.xor %arg1, %arg2 : i32
  %5 = llvm.and %4, %arg0 : i32
  %6 = llvm.xor %5, %0 : i32
  %7 = llvm.and %3, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def or_not_and_and_not_and_xor_commute1_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg2, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %2, %arg0 : i32
  %4 = llvm.xor %arg1, %arg2 : i32
  %5 = llvm.and %4, %arg0 : i32
  %6 = llvm.xor %5, %3 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
theorem or_not_and_and_not_and_xor_commute1_proof : or_not_and_and_not_and_xor_commute1_before ⊑ or_not_and_and_not_and_xor_commute1_after := by
  unfold or_not_and_and_not_and_xor_commute1_before or_not_and_and_not_and_xor_commute1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_not_and_and_not_and_xor_commute1
  apply or_not_and_and_not_and_xor_commute1_thm
  ---END or_not_and_and_not_and_xor_commute1



def or_not_and_and_not_and_xor_commute2_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg0 : i32
  %3 = llvm.and %arg1, %arg2 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.or %2, %4 : i32
  %6 = llvm.xor %arg1, %arg2 : i32
  %7 = llvm.and %6, %2 : i32
  %8 = llvm.xor %7, %1 : i32
  %9 = llvm.and %5, %8 : i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def or_not_and_and_not_and_xor_commute2_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg0 : i32
  %3 = llvm.and %arg1, %arg2 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.or %2, %4 : i32
  %6 = llvm.xor %arg1, %arg2 : i32
  %7 = llvm.and %6, %2 : i32
  %8 = llvm.xor %7, %5 : i32
  "llvm.return"(%8) : (i32) -> ()
}
]
theorem or_not_and_and_not_and_xor_commute2_proof : or_not_and_and_not_and_xor_commute2_before ⊑ or_not_and_and_not_and_xor_commute2_after := by
  unfold or_not_and_and_not_and_xor_commute2_before or_not_and_and_not_and_xor_commute2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_not_and_and_not_and_xor_commute2
  apply or_not_and_and_not_and_xor_commute2_thm
  ---END or_not_and_and_not_and_xor_commute2



def or_not_and_and_not_and_xor_commute3_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg1, %arg2 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %2, %arg0 : i32
  %4 = llvm.xor %arg2, %arg1 : i32
  %5 = llvm.and %4, %arg0 : i32
  %6 = llvm.xor %5, %0 : i32
  %7 = llvm.and %3, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def or_not_and_and_not_and_xor_commute3_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg1, %arg2 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %2, %arg0 : i32
  %4 = llvm.xor %arg2, %arg1 : i32
  %5 = llvm.and %4, %arg0 : i32
  %6 = llvm.xor %5, %3 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
theorem or_not_and_and_not_and_xor_commute3_proof : or_not_and_and_not_and_xor_commute3_before ⊑ or_not_and_and_not_and_xor_commute3_after := by
  unfold or_not_and_and_not_and_xor_commute3_before or_not_and_and_not_and_xor_commute3_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_not_and_and_not_and_xor_commute3
  apply or_not_and_and_not_and_xor_commute3_thm
  ---END or_not_and_and_not_and_xor_commute3



def or_not_and_and_not_and_xor_commute4_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg0 : i32
  %3 = llvm.and %arg1, %arg2 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.or %2, %4 : i32
  %6 = llvm.xor %arg1, %arg2 : i32
  %7 = llvm.and %2, %6 : i32
  %8 = llvm.xor %7, %1 : i32
  %9 = llvm.and %5, %8 : i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def or_not_and_and_not_and_xor_commute4_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg0 : i32
  %3 = llvm.and %arg1, %arg2 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.or %2, %4 : i32
  %6 = llvm.xor %arg1, %arg2 : i32
  %7 = llvm.and %2, %6 : i32
  %8 = llvm.xor %7, %5 : i32
  "llvm.return"(%8) : (i32) -> ()
}
]
theorem or_not_and_and_not_and_xor_commute4_proof : or_not_and_and_not_and_xor_commute4_before ⊑ or_not_and_and_not_and_xor_commute4_after := by
  unfold or_not_and_and_not_and_xor_commute4_before or_not_and_and_not_and_xor_commute4_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_not_and_and_not_and_xor_commute4
  apply or_not_and_and_not_and_xor_commute4_thm
  ---END or_not_and_and_not_and_xor_commute4



def or_not_and_and_not_and_xor_commute5_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg1, %arg2 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %2, %arg0 : i32
  %4 = llvm.xor %arg1, %arg2 : i32
  %5 = llvm.and %4, %arg0 : i32
  %6 = llvm.xor %5, %0 : i32
  %7 = llvm.and %6, %3 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def or_not_and_and_not_and_xor_commute5_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg1, %arg2 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %2, %arg0 : i32
  %4 = llvm.xor %arg1, %arg2 : i32
  %5 = llvm.and %4, %arg0 : i32
  %6 = llvm.xor %5, %3 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
theorem or_not_and_and_not_and_xor_commute5_proof : or_not_and_and_not_and_xor_commute5_before ⊑ or_not_and_and_not_and_xor_commute5_after := by
  unfold or_not_and_and_not_and_xor_commute5_before or_not_and_and_not_and_xor_commute5_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_not_and_and_not_and_xor_commute5
  apply or_not_and_and_not_and_xor_commute5_thm
  ---END or_not_and_and_not_and_xor_commute5



def not_and_and_or_not_or_or_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.or %arg1, %arg0 : i32
  %2 = llvm.or %1, %arg2 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.xor %arg0, %0 : i32
  %5 = llvm.and %4, %arg1 : i32
  %6 = llvm.and %5, %arg2 : i32
  %7 = llvm.or %6, %3 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def not_and_and_or_not_or_or_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg2, %arg1 : i32
  %2 = llvm.or %1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem not_and_and_or_not_or_or_proof : not_and_and_or_not_or_or_before ⊑ not_and_and_or_not_or_or_after := by
  unfold not_and_and_or_not_or_or_before not_and_and_or_not_or_or_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN not_and_and_or_not_or_or
  apply not_and_and_or_not_or_or_thm
  ---END not_and_and_or_not_or_or



def not_and_and_or_not_or_or_commute1_or_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.or %arg2, %arg0 : i32
  %2 = llvm.or %1, %arg1 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.xor %arg0, %0 : i32
  %5 = llvm.and %4, %arg1 : i32
  %6 = llvm.and %5, %arg2 : i32
  %7 = llvm.or %6, %3 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def not_and_and_or_not_or_or_commute1_or_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg2, %arg1 : i32
  %2 = llvm.or %1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem not_and_and_or_not_or_or_commute1_or_proof : not_and_and_or_not_or_or_commute1_or_before ⊑ not_and_and_or_not_or_or_commute1_or_after := by
  unfold not_and_and_or_not_or_or_commute1_or_before not_and_and_or_not_or_or_commute1_or_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN not_and_and_or_not_or_or_commute1_or
  apply not_and_and_or_not_or_or_commute1_or_thm
  ---END not_and_and_or_not_or_or_commute1_or



def not_and_and_or_not_or_or_commute2_or_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.or %arg1, %arg2 : i32
  %2 = llvm.or %1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.xor %arg0, %0 : i32
  %5 = llvm.and %4, %arg1 : i32
  %6 = llvm.and %5, %arg2 : i32
  %7 = llvm.or %6, %3 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def not_and_and_or_not_or_or_commute2_or_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg2, %arg1 : i32
  %2 = llvm.or %1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem not_and_and_or_not_or_or_commute2_or_proof : not_and_and_or_not_or_or_commute2_or_before ⊑ not_and_and_or_not_or_or_commute2_or_after := by
  unfold not_and_and_or_not_or_or_commute2_or_before not_and_and_or_not_or_or_commute2_or_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN not_and_and_or_not_or_or_commute2_or
  apply not_and_and_or_not_or_or_commute2_or_thm
  ---END not_and_and_or_not_or_or_commute2_or



def not_and_and_or_not_or_or_commute1_and_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.or %arg1, %arg0 : i32
  %2 = llvm.or %1, %arg2 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.xor %arg0, %0 : i32
  %5 = llvm.and %4, %arg2 : i32
  %6 = llvm.and %5, %arg1 : i32
  %7 = llvm.or %6, %3 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def not_and_and_or_not_or_or_commute1_and_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %arg2 : i32
  %2 = llvm.or %1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem not_and_and_or_not_or_or_commute1_and_proof : not_and_and_or_not_or_or_commute1_and_before ⊑ not_and_and_or_not_or_or_commute1_and_after := by
  unfold not_and_and_or_not_or_or_commute1_and_before not_and_and_or_not_or_or_commute1_and_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN not_and_and_or_not_or_or_commute1_and
  apply not_and_and_or_not_or_or_commute1_and_thm
  ---END not_and_and_or_not_or_or_commute1_and



def not_and_and_or_not_or_or_commute2_and_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.or %arg1, %arg0 : i32
  %2 = llvm.or %1, %arg2 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.xor %arg0, %0 : i32
  %5 = llvm.and %arg1, %arg2 : i32
  %6 = llvm.and %5, %4 : i32
  %7 = llvm.or %6, %3 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def not_and_and_or_not_or_or_commute2_and_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %arg2 : i32
  %2 = llvm.or %1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem not_and_and_or_not_or_or_commute2_and_proof : not_and_and_or_not_or_or_commute2_and_before ⊑ not_and_and_or_not_or_or_commute2_and_after := by
  unfold not_and_and_or_not_or_or_commute2_and_before not_and_and_or_not_or_or_commute2_and_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN not_and_and_or_not_or_or_commute2_and
  apply not_and_and_or_not_or_or_commute2_and_thm
  ---END not_and_and_or_not_or_or_commute2_and



def not_and_and_or_not_or_or_commute1_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.or %arg0, %arg1 : i32
  %2 = llvm.or %1, %arg2 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.xor %arg0, %0 : i32
  %5 = llvm.and %4, %arg1 : i32
  %6 = llvm.and %5, %arg2 : i32
  %7 = llvm.or %6, %3 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def not_and_and_or_not_or_or_commute1_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg2, %arg1 : i32
  %2 = llvm.or %1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem not_and_and_or_not_or_or_commute1_proof : not_and_and_or_not_or_or_commute1_before ⊑ not_and_and_or_not_or_or_commute1_after := by
  unfold not_and_and_or_not_or_or_commute1_before not_and_and_or_not_or_or_commute1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN not_and_and_or_not_or_or_commute1
  apply not_and_and_or_not_or_or_commute1_thm
  ---END not_and_and_or_not_or_or_commute1



def not_and_and_or_not_or_or_commute2_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg2 : i32
  %3 = llvm.or %arg1, %arg0 : i32
  %4 = llvm.or %2, %3 : i32
  %5 = llvm.xor %4, %1 : i32
  %6 = llvm.xor %arg0, %1 : i32
  %7 = llvm.and %6, %arg1 : i32
  %8 = llvm.and %7, %2 : i32
  %9 = llvm.or %8, %5 : i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def not_and_and_or_not_or_or_commute2_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg2 : i32
  %3 = llvm.xor %2, %arg1 : i32
  %4 = llvm.or %3, %arg0 : i32
  %5 = llvm.xor %4, %1 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
theorem not_and_and_or_not_or_or_commute2_proof : not_and_and_or_not_or_or_commute2_before ⊑ not_and_and_or_not_or_or_commute2_after := by
  unfold not_and_and_or_not_or_or_commute2_before not_and_and_or_not_or_or_commute2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN not_and_and_or_not_or_or_commute2
  apply not_and_and_or_not_or_or_commute2_thm
  ---END not_and_and_or_not_or_or_commute2



def not_and_and_or_not_or_or_commute3_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg1 : i32
  %3 = llvm.or %2, %arg0 : i32
  %4 = llvm.or %3, %arg2 : i32
  %5 = llvm.xor %4, %1 : i32
  %6 = llvm.xor %arg0, %1 : i32
  %7 = llvm.and %2, %6 : i32
  %8 = llvm.and %7, %arg2 : i32
  %9 = llvm.or %8, %5 : i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def not_and_and_or_not_or_or_commute3_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg1 : i32
  %3 = llvm.xor %2, %arg2 : i32
  %4 = llvm.or %3, %arg0 : i32
  %5 = llvm.xor %4, %1 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
theorem not_and_and_or_not_or_or_commute3_proof : not_and_and_or_not_or_or_commute3_before ⊑ not_and_and_or_not_or_or_commute3_after := by
  unfold not_and_and_or_not_or_or_commute3_before not_and_and_or_not_or_or_commute3_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN not_and_and_or_not_or_or_commute3
  apply not_and_and_or_not_or_or_commute3_thm
  ---END not_and_and_or_not_or_or_commute3



def not_and_and_or_not_or_or_commute4_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg2 : i32
  %3 = llvm.or %arg1, %arg0 : i32
  %4 = llvm.or %3, %2 : i32
  %5 = llvm.xor %4, %1 : i32
  %6 = llvm.xor %arg0, %1 : i32
  %7 = llvm.and %6, %arg1 : i32
  %8 = llvm.and %2, %7 : i32
  %9 = llvm.or %8, %5 : i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def not_and_and_or_not_or_or_commute4_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg2 : i32
  %3 = llvm.xor %2, %arg1 : i32
  %4 = llvm.or %3, %arg0 : i32
  %5 = llvm.xor %4, %1 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
theorem not_and_and_or_not_or_or_commute4_proof : not_and_and_or_not_or_or_commute4_before ⊑ not_and_and_or_not_or_or_commute4_after := by
  unfold not_and_and_or_not_or_or_commute4_before not_and_and_or_not_or_or_commute4_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN not_and_and_or_not_or_or_commute4
  apply not_and_and_or_not_or_or_commute4_thm
  ---END not_and_and_or_not_or_or_commute4



def not_or_or_and_not_and_and_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg1, %arg0 : i32
  %2 = llvm.and %1, %arg2 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.xor %arg0, %0 : i32
  %5 = llvm.or %4, %arg1 : i32
  %6 = llvm.or %5, %arg2 : i32
  %7 = llvm.and %6, %3 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def not_or_or_and_not_and_and_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.xor %arg2, %arg1 : i32
  %3 = llvm.or %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem not_or_or_and_not_and_and_proof : not_or_or_and_not_and_and_before ⊑ not_or_or_and_not_and_and_after := by
  unfold not_or_or_and_not_and_and_before not_or_or_and_not_and_and_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN not_or_or_and_not_and_and
  apply not_or_or_and_not_and_and_thm
  ---END not_or_or_and_not_and_and



def not_or_or_and_not_and_and_commute1_and_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg2, %arg0 : i32
  %2 = llvm.and %1, %arg1 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.xor %arg0, %0 : i32
  %5 = llvm.or %4, %arg1 : i32
  %6 = llvm.or %5, %arg2 : i32
  %7 = llvm.and %6, %3 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def not_or_or_and_not_and_and_commute1_and_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.xor %arg2, %arg1 : i32
  %3 = llvm.or %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem not_or_or_and_not_and_and_commute1_and_proof : not_or_or_and_not_and_and_commute1_and_before ⊑ not_or_or_and_not_and_and_commute1_and_after := by
  unfold not_or_or_and_not_and_and_commute1_and_before not_or_or_and_not_and_and_commute1_and_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN not_or_or_and_not_and_and_commute1_and
  apply not_or_or_and_not_and_and_commute1_and_thm
  ---END not_or_or_and_not_and_and_commute1_and



def not_or_or_and_not_and_and_commute2_and_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg1, %arg2 : i32
  %2 = llvm.and %1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.xor %arg0, %0 : i32
  %5 = llvm.or %4, %arg1 : i32
  %6 = llvm.or %5, %arg2 : i32
  %7 = llvm.and %6, %3 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def not_or_or_and_not_and_and_commute2_and_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.xor %arg2, %arg1 : i32
  %3 = llvm.or %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem not_or_or_and_not_and_and_commute2_and_proof : not_or_or_and_not_and_and_commute2_and_before ⊑ not_or_or_and_not_and_and_commute2_and_after := by
  unfold not_or_or_and_not_and_and_commute2_and_before not_or_or_and_not_and_and_commute2_and_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN not_or_or_and_not_and_and_commute2_and
  apply not_or_or_and_not_and_and_commute2_and_thm
  ---END not_or_or_and_not_and_and_commute2_and



def not_or_or_and_not_and_and_commute1_or_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg1, %arg0 : i32
  %2 = llvm.and %1, %arg2 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.xor %arg0, %0 : i32
  %5 = llvm.or %4, %arg2 : i32
  %6 = llvm.or %5, %arg1 : i32
  %7 = llvm.and %6, %3 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def not_or_or_and_not_and_and_commute1_or_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.xor %arg1, %arg2 : i32
  %3 = llvm.or %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem not_or_or_and_not_and_and_commute1_or_proof : not_or_or_and_not_and_and_commute1_or_before ⊑ not_or_or_and_not_and_and_commute1_or_after := by
  unfold not_or_or_and_not_and_and_commute1_or_before not_or_or_and_not_and_and_commute1_or_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN not_or_or_and_not_and_and_commute1_or
  apply not_or_or_and_not_and_and_commute1_or_thm
  ---END not_or_or_and_not_and_and_commute1_or



def not_or_or_and_not_and_and_commute2_or_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg1, %arg0 : i32
  %2 = llvm.and %1, %arg2 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.xor %arg0, %0 : i32
  %5 = llvm.or %arg1, %arg2 : i32
  %6 = llvm.or %5, %4 : i32
  %7 = llvm.and %6, %3 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def not_or_or_and_not_and_and_commute2_or_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.xor %arg1, %arg2 : i32
  %3 = llvm.or %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem not_or_or_and_not_and_and_commute2_or_proof : not_or_or_and_not_and_and_commute2_or_before ⊑ not_or_or_and_not_and_and_commute2_or_after := by
  unfold not_or_or_and_not_and_and_commute2_or_before not_or_or_and_not_and_and_commute2_or_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN not_or_or_and_not_and_and_commute2_or
  apply not_or_or_and_not_and_and_commute2_or_thm
  ---END not_or_or_and_not_and_and_commute2_or



def not_or_or_and_not_and_and_commute1_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = llvm.and %1, %arg2 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.xor %arg0, %0 : i32
  %5 = llvm.or %4, %arg1 : i32
  %6 = llvm.or %5, %arg2 : i32
  %7 = llvm.and %6, %3 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def not_or_or_and_not_and_and_commute1_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.xor %arg2, %arg1 : i32
  %3 = llvm.or %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem not_or_or_and_not_and_and_commute1_proof : not_or_or_and_not_and_and_commute1_before ⊑ not_or_or_and_not_and_and_commute1_after := by
  unfold not_or_or_and_not_and_and_commute1_before not_or_or_and_not_and_and_commute1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN not_or_or_and_not_and_and_commute1
  apply not_or_or_and_not_and_and_commute1_thm
  ---END not_or_or_and_not_and_and_commute1



def not_or_or_and_not_and_and_commute2_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg2 : i32
  %3 = llvm.and %arg1, %arg0 : i32
  %4 = llvm.and %2, %3 : i32
  %5 = llvm.xor %4, %1 : i32
  %6 = llvm.xor %arg0, %1 : i32
  %7 = llvm.or %6, %arg1 : i32
  %8 = llvm.or %7, %2 : i32
  %9 = llvm.and %8, %5 : i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def not_or_or_and_not_and_and_commute2_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg2 : i32
  %3 = llvm.xor %arg0, %1 : i32
  %4 = llvm.xor %2, %arg1 : i32
  %5 = llvm.or %4, %3 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
theorem not_or_or_and_not_and_and_commute2_proof : not_or_or_and_not_and_and_commute2_before ⊑ not_or_or_and_not_and_and_commute2_after := by
  unfold not_or_or_and_not_and_and_commute2_before not_or_or_and_not_and_and_commute2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN not_or_or_and_not_and_and_commute2
  apply not_or_or_and_not_and_and_commute2_thm
  ---END not_or_or_and_not_and_and_commute2



def not_or_or_and_not_and_and_commute3_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg1 : i32
  %3 = llvm.and %2, %arg0 : i32
  %4 = llvm.and %3, %arg2 : i32
  %5 = llvm.xor %4, %1 : i32
  %6 = llvm.xor %arg0, %1 : i32
  %7 = llvm.or %2, %6 : i32
  %8 = llvm.or %7, %arg2 : i32
  %9 = llvm.and %8, %5 : i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def not_or_or_and_not_and_and_commute3_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg1 : i32
  %3 = llvm.xor %arg0, %1 : i32
  %4 = llvm.xor %2, %arg2 : i32
  %5 = llvm.or %4, %3 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
theorem not_or_or_and_not_and_and_commute3_proof : not_or_or_and_not_and_and_commute3_before ⊑ not_or_or_and_not_and_and_commute3_after := by
  unfold not_or_or_and_not_and_and_commute3_before not_or_or_and_not_and_and_commute3_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN not_or_or_and_not_and_and_commute3
  apply not_or_or_and_not_and_and_commute3_thm
  ---END not_or_or_and_not_and_and_commute3



def not_or_or_and_not_and_and_commute4_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg2 : i32
  %3 = llvm.and %arg1, %arg0 : i32
  %4 = llvm.and %3, %2 : i32
  %5 = llvm.xor %4, %1 : i32
  %6 = llvm.xor %arg0, %1 : i32
  %7 = llvm.or %6, %arg1 : i32
  %8 = llvm.or %2, %7 : i32
  %9 = llvm.and %8, %5 : i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def not_or_or_and_not_and_and_commute4_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg2 : i32
  %3 = llvm.xor %arg0, %1 : i32
  %4 = llvm.xor %2, %arg1 : i32
  %5 = llvm.or %4, %3 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
theorem not_or_or_and_not_and_and_commute4_proof : not_or_or_and_not_and_and_commute4_before ⊑ not_or_or_and_not_and_and_commute4_after := by
  unfold not_or_or_and_not_and_and_commute4_before not_or_or_and_not_and_and_commute4_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN not_or_or_and_not_and_and_commute4
  apply not_or_or_and_not_and_and_commute4_thm
  ---END not_or_or_and_not_and_and_commute4



def not_and_and_or_no_or_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.or %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.xor %arg0, %0 : i32
  %4 = llvm.and %3, %arg1 : i32
  %5 = llvm.and %4, %arg2 : i32
  %6 = llvm.or %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def not_and_and_or_no_or_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.xor %arg1, %0 : i32
  %3 = llvm.or %2, %arg2 : i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem not_and_and_or_no_or_proof : not_and_and_or_no_or_before ⊑ not_and_and_or_no_or_after := by
  unfold not_and_and_or_no_or_before not_and_and_or_no_or_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN not_and_and_or_no_or
  apply not_and_and_or_no_or_thm
  ---END not_and_and_or_no_or



def not_and_and_or_no_or_commute1_and_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.or %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.xor %arg0, %0 : i32
  %4 = llvm.and %arg2, %arg1 : i32
  %5 = llvm.and %4, %3 : i32
  %6 = llvm.or %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def not_and_and_or_no_or_commute1_and_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.xor %arg1, %0 : i32
  %3 = llvm.or %2, %arg2 : i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem not_and_and_or_no_or_commute1_and_proof : not_and_and_or_no_or_commute1_and_before ⊑ not_and_and_or_no_or_commute1_and_after := by
  unfold not_and_and_or_no_or_commute1_and_before not_and_and_or_no_or_commute1_and_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN not_and_and_or_no_or_commute1_and
  apply not_and_and_or_no_or_commute1_and_thm
  ---END not_and_and_or_no_or_commute1_and



def not_and_and_or_no_or_commute2_and_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.or %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.xor %arg0, %0 : i32
  %4 = llvm.and %3, %arg2 : i32
  %5 = llvm.and %4, %arg1 : i32
  %6 = llvm.or %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def not_and_and_or_no_or_commute2_and_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.xor %arg1, %0 : i32
  %3 = llvm.or %2, %arg2 : i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem not_and_and_or_no_or_commute2_and_proof : not_and_and_or_no_or_commute2_and_before ⊑ not_and_and_or_no_or_commute2_and_after := by
  unfold not_and_and_or_no_or_commute2_and_before not_and_and_or_no_or_commute2_and_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN not_and_and_or_no_or_commute2_and
  apply not_and_and_or_no_or_commute2_and_thm
  ---END not_and_and_or_no_or_commute2_and



def not_and_and_or_no_or_commute1_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.or %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.xor %arg0, %0 : i32
  %4 = llvm.and %3, %arg1 : i32
  %5 = llvm.and %4, %arg2 : i32
  %6 = llvm.or %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def not_and_and_or_no_or_commute1_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.xor %arg1, %0 : i32
  %3 = llvm.or %2, %arg2 : i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem not_and_and_or_no_or_commute1_proof : not_and_and_or_no_or_commute1_before ⊑ not_and_and_or_no_or_commute1_after := by
  unfold not_and_and_or_no_or_commute1_before not_and_and_or_no_or_commute1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN not_and_and_or_no_or_commute1
  apply not_and_and_or_no_or_commute1_thm
  ---END not_and_and_or_no_or_commute1



def not_and_and_or_no_or_commute2_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg1 : i32
  %3 = llvm.or %2, %arg0 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.xor %arg0, %1 : i32
  %6 = llvm.and %2, %5 : i32
  %7 = llvm.and %6, %arg2 : i32
  %8 = llvm.or %7, %4 : i32
  "llvm.return"(%8) : (i32) -> ()
}
]
def not_and_and_or_no_or_commute2_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg1 : i32
  %3 = llvm.xor %arg0, %1 : i32
  %4 = llvm.xor %2, %1 : i32
  %5 = llvm.or %4, %arg2 : i32
  %6 = llvm.and %5, %3 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
theorem not_and_and_or_no_or_commute2_proof : not_and_and_or_no_or_commute2_before ⊑ not_and_and_or_no_or_commute2_after := by
  unfold not_and_and_or_no_or_commute2_before not_and_and_or_no_or_commute2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN not_and_and_or_no_or_commute2
  apply not_and_and_or_no_or_commute2_thm
  ---END not_and_and_or_no_or_commute2



def not_and_and_or_no_or_commute3_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg2 : i32
  %3 = llvm.or %arg1, %arg0 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.xor %arg0, %1 : i32
  %6 = llvm.and %5, %arg1 : i32
  %7 = llvm.and %2, %6 : i32
  %8 = llvm.or %7, %4 : i32
  "llvm.return"(%8) : (i32) -> ()
}
]
def not_and_and_or_no_or_commute3_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg2 : i32
  %3 = llvm.xor %arg0, %1 : i32
  %4 = llvm.xor %arg1, %1 : i32
  %5 = llvm.or %2, %4 : i32
  %6 = llvm.and %5, %3 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
theorem not_and_and_or_no_or_commute3_proof : not_and_and_or_no_or_commute3_before ⊑ not_and_and_or_no_or_commute3_after := by
  unfold not_and_and_or_no_or_commute3_before not_and_and_or_no_or_commute3_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN not_and_and_or_no_or_commute3
  apply not_and_and_or_no_or_commute3_thm
  ---END not_and_and_or_no_or_commute3



def not_or_or_and_no_and_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.xor %arg0, %0 : i32
  %4 = llvm.or %3, %arg1 : i32
  %5 = llvm.or %4, %arg2 : i32
  %6 = llvm.and %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def not_or_or_and_no_and_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.xor %arg1, %0 : i32
  %3 = llvm.and %2, %arg2 : i32
  %4 = llvm.or %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem not_or_or_and_no_and_proof : not_or_or_and_no_and_before ⊑ not_or_or_and_no_and_after := by
  unfold not_or_or_and_no_and_before not_or_or_and_no_and_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN not_or_or_and_no_and
  apply not_or_or_and_no_and_thm
  ---END not_or_or_and_no_and



def not_or_or_and_no_and_commute1_or_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.xor %arg0, %0 : i32
  %4 = llvm.or %arg2, %arg1 : i32
  %5 = llvm.or %4, %3 : i32
  %6 = llvm.and %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def not_or_or_and_no_and_commute1_or_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.xor %arg1, %0 : i32
  %3 = llvm.and %2, %arg2 : i32
  %4 = llvm.or %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem not_or_or_and_no_and_commute1_or_proof : not_or_or_and_no_and_commute1_or_before ⊑ not_or_or_and_no_and_commute1_or_after := by
  unfold not_or_or_and_no_and_commute1_or_before not_or_or_and_no_and_commute1_or_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN not_or_or_and_no_and_commute1_or
  apply not_or_or_and_no_and_commute1_or_thm
  ---END not_or_or_and_no_and_commute1_or



def not_or_or_and_no_and_commute2_or_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.xor %arg0, %0 : i32
  %4 = llvm.or %3, %arg2 : i32
  %5 = llvm.or %4, %arg1 : i32
  %6 = llvm.and %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def not_or_or_and_no_and_commute2_or_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.xor %arg1, %0 : i32
  %3 = llvm.and %2, %arg2 : i32
  %4 = llvm.or %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem not_or_or_and_no_and_commute2_or_proof : not_or_or_and_no_and_commute2_or_before ⊑ not_or_or_and_no_and_commute2_or_after := by
  unfold not_or_or_and_no_and_commute2_or_before not_or_or_and_no_and_commute2_or_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN not_or_or_and_no_and_commute2_or
  apply not_or_or_and_no_and_commute2_or_thm
  ---END not_or_or_and_no_and_commute2_or



def not_or_or_and_no_and_commute1_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.xor %arg0, %0 : i32
  %4 = llvm.or %3, %arg1 : i32
  %5 = llvm.or %4, %arg2 : i32
  %6 = llvm.and %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def not_or_or_and_no_and_commute1_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.xor %arg1, %0 : i32
  %3 = llvm.and %2, %arg2 : i32
  %4 = llvm.or %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem not_or_or_and_no_and_commute1_proof : not_or_or_and_no_and_commute1_before ⊑ not_or_or_and_no_and_commute1_after := by
  unfold not_or_or_and_no_and_commute1_before not_or_or_and_no_and_commute1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN not_or_or_and_no_and_commute1
  apply not_or_or_and_no_and_commute1_thm
  ---END not_or_or_and_no_and_commute1



def not_or_or_and_no_and_commute2_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg1 : i32
  %3 = llvm.and %2, %arg0 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.xor %arg0, %1 : i32
  %6 = llvm.or %2, %5 : i32
  %7 = llvm.or %6, %arg2 : i32
  %8 = llvm.and %7, %4 : i32
  "llvm.return"(%8) : (i32) -> ()
}
]
def not_or_or_and_no_and_commute2_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg1 : i32
  %3 = llvm.xor %arg0, %1 : i32
  %4 = llvm.xor %2, %1 : i32
  %5 = llvm.and %4, %arg2 : i32
  %6 = llvm.or %5, %3 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
theorem not_or_or_and_no_and_commute2_proof : not_or_or_and_no_and_commute2_before ⊑ not_or_or_and_no_and_commute2_after := by
  unfold not_or_or_and_no_and_commute2_before not_or_or_and_no_and_commute2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN not_or_or_and_no_and_commute2
  apply not_or_or_and_no_and_commute2_thm
  ---END not_or_or_and_no_and_commute2



def not_or_or_and_no_and_commute3_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg2 : i32
  %3 = llvm.and %arg1, %arg0 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.xor %arg0, %1 : i32
  %6 = llvm.or %5, %arg1 : i32
  %7 = llvm.or %2, %6 : i32
  %8 = llvm.and %7, %4 : i32
  "llvm.return"(%8) : (i32) -> ()
}
]
def not_or_or_and_no_and_commute3_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.sdiv %0, %arg2 : i32
  %3 = llvm.xor %arg0, %1 : i32
  %4 = llvm.xor %arg1, %1 : i32
  %5 = llvm.and %2, %4 : i32
  %6 = llvm.or %5, %3 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
theorem not_or_or_and_no_and_commute3_proof : not_or_or_and_no_and_commute3_before ⊑ not_or_or_and_no_and_commute3_after := by
  unfold not_or_or_and_no_and_commute3_before not_or_or_and_no_and_commute3_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN not_or_or_and_no_and_commute3
  apply not_or_or_and_no_and_commute3_thm
  ---END not_or_or_and_no_and_commute3



def and_orn_xor_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{value = -1 : i4}> : () -> i4
  %1 = llvm.xor %arg0, %arg1 : i4
  %2 = llvm.xor %arg0, %0 : i4
  %3 = llvm.or %2, %arg1 : i4
  %4 = llvm.and %3, %1 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def and_orn_xor_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{value = -1 : i4}> : () -> i4
  %1 = llvm.xor %arg0, %0 : i4
  %2 = llvm.and %1, %arg1 : i4
  "llvm.return"(%2) : (i4) -> ()
}
]
theorem and_orn_xor_proof : and_orn_xor_before ⊑ and_orn_xor_after := by
  unfold and_orn_xor_before and_orn_xor_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN and_orn_xor
  apply and_orn_xor_thm
  ---END and_orn_xor



def and_orn_xor_commute8_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.mul %arg0, %arg0 : i32
  %2 = llvm.mul %arg1, %arg1 : i32
  %3 = llvm.xor %2, %1 : i32
  %4 = llvm.xor %1, %0 : i32
  %5 = llvm.or %2, %4 : i32
  %6 = llvm.and %3, %5 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def and_orn_xor_commute8_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.mul %arg0, %arg0 : i32
  %2 = llvm.mul %arg1, %arg1 : i32
  %3 = llvm.xor %1, %0 : i32
  %4 = llvm.and %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem and_orn_xor_commute8_proof : and_orn_xor_commute8_before ⊑ and_orn_xor_commute8_after := by
  unfold and_orn_xor_commute8_before and_orn_xor_commute8_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN and_orn_xor_commute8
  apply and_orn_xor_commute8_thm
  ---END and_orn_xor_commute8



def canonicalize_logic_first_or0_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 112 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 15 : i32}> : () -> i32
  %2 = llvm.add %arg0, %0 : i32
  %3 = llvm.or %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def canonicalize_logic_first_or0_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 15 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 112 : i32}> : () -> i32
  %2 = llvm.or %arg0, %0 : i32
  %3 = llvm.add %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem canonicalize_logic_first_or0_proof : canonicalize_logic_first_or0_before ⊑ canonicalize_logic_first_or0_after := by
  unfold canonicalize_logic_first_or0_before canonicalize_logic_first_or0_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN canonicalize_logic_first_or0
  apply canonicalize_logic_first_or0_thm
  ---END canonicalize_logic_first_or0



def canonicalize_logic_first_or0_nsw_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 112 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 15 : i32}> : () -> i32
  %2 = llvm.add %arg0, %0 : i32
  %3 = llvm.or %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def canonicalize_logic_first_or0_nsw_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 15 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 112 : i32}> : () -> i32
  %2 = llvm.or %arg0, %0 : i32
  %3 = llvm.add %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem canonicalize_logic_first_or0_nsw_proof : canonicalize_logic_first_or0_nsw_before ⊑ canonicalize_logic_first_or0_nsw_after := by
  unfold canonicalize_logic_first_or0_nsw_before canonicalize_logic_first_or0_nsw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN canonicalize_logic_first_or0_nsw
  apply canonicalize_logic_first_or0_nsw_thm
  ---END canonicalize_logic_first_or0_nsw



def canonicalize_logic_first_or0_nswnuw_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 112 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 15 : i32}> : () -> i32
  %2 = llvm.add %arg0, %0 : i32
  %3 = llvm.or %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def canonicalize_logic_first_or0_nswnuw_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 15 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 112 : i32}> : () -> i32
  %2 = llvm.or %arg0, %0 : i32
  %3 = llvm.add %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem canonicalize_logic_first_or0_nswnuw_proof : canonicalize_logic_first_or0_nswnuw_before ⊑ canonicalize_logic_first_or0_nswnuw_after := by
  unfold canonicalize_logic_first_or0_nswnuw_before canonicalize_logic_first_or0_nswnuw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN canonicalize_logic_first_or0_nswnuw
  apply canonicalize_logic_first_or0_nswnuw_thm
  ---END canonicalize_logic_first_or0_nswnuw



def canonicalize_logic_first_and0_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 48 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = -10 : i8}> : () -> i8
  %2 = llvm.add %arg0, %0 : i8
  %3 = llvm.and %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def canonicalize_logic_first_and0_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = -10 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 48 : i8}> : () -> i8
  %2 = llvm.and %arg0, %0 : i8
  %3 = llvm.add %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem canonicalize_logic_first_and0_proof : canonicalize_logic_first_and0_before ⊑ canonicalize_logic_first_and0_after := by
  unfold canonicalize_logic_first_and0_before canonicalize_logic_first_and0_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN canonicalize_logic_first_and0
  apply canonicalize_logic_first_and0_thm
  ---END canonicalize_logic_first_and0



def canonicalize_logic_first_and0_nsw_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 48 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = -10 : i8}> : () -> i8
  %2 = llvm.add %arg0, %0 : i8
  %3 = llvm.and %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def canonicalize_logic_first_and0_nsw_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = -10 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 48 : i8}> : () -> i8
  %2 = llvm.and %arg0, %0 : i8
  %3 = llvm.add %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem canonicalize_logic_first_and0_nsw_proof : canonicalize_logic_first_and0_nsw_before ⊑ canonicalize_logic_first_and0_nsw_after := by
  unfold canonicalize_logic_first_and0_nsw_before canonicalize_logic_first_and0_nsw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN canonicalize_logic_first_and0_nsw
  apply canonicalize_logic_first_and0_nsw_thm
  ---END canonicalize_logic_first_and0_nsw



def canonicalize_logic_first_and0_nswnuw_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 48 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = -10 : i8}> : () -> i8
  %2 = llvm.add %arg0, %0 : i8
  %3 = llvm.and %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def canonicalize_logic_first_and0_nswnuw_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = -10 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 48 : i8}> : () -> i8
  %2 = llvm.and %arg0, %0 : i8
  %3 = llvm.add %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem canonicalize_logic_first_and0_nswnuw_proof : canonicalize_logic_first_and0_nswnuw_before ⊑ canonicalize_logic_first_and0_nswnuw_after := by
  unfold canonicalize_logic_first_and0_nswnuw_before canonicalize_logic_first_and0_nswnuw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN canonicalize_logic_first_and0_nswnuw
  apply canonicalize_logic_first_and0_nswnuw_thm
  ---END canonicalize_logic_first_and0_nswnuw



def canonicalize_logic_first_xor_0_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 96 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 31 : i8}> : () -> i8
  %2 = llvm.add %arg0, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def canonicalize_logic_first_xor_0_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 31 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 96 : i8}> : () -> i8
  %2 = llvm.xor %arg0, %0 : i8
  %3 = llvm.add %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem canonicalize_logic_first_xor_0_proof : canonicalize_logic_first_xor_0_before ⊑ canonicalize_logic_first_xor_0_after := by
  unfold canonicalize_logic_first_xor_0_before canonicalize_logic_first_xor_0_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN canonicalize_logic_first_xor_0
  apply canonicalize_logic_first_xor_0_thm
  ---END canonicalize_logic_first_xor_0



def canonicalize_logic_first_xor_0_nsw_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 96 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 31 : i8}> : () -> i8
  %2 = llvm.add %arg0, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def canonicalize_logic_first_xor_0_nsw_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 31 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 96 : i8}> : () -> i8
  %2 = llvm.xor %arg0, %0 : i8
  %3 = llvm.add %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem canonicalize_logic_first_xor_0_nsw_proof : canonicalize_logic_first_xor_0_nsw_before ⊑ canonicalize_logic_first_xor_0_nsw_after := by
  unfold canonicalize_logic_first_xor_0_nsw_before canonicalize_logic_first_xor_0_nsw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN canonicalize_logic_first_xor_0_nsw
  apply canonicalize_logic_first_xor_0_nsw_thm
  ---END canonicalize_logic_first_xor_0_nsw



def canonicalize_logic_first_xor_0_nswnuw_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 96 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 31 : i8}> : () -> i8
  %2 = llvm.add %arg0, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def canonicalize_logic_first_xor_0_nswnuw_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 31 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 96 : i8}> : () -> i8
  %2 = llvm.xor %arg0, %0 : i8
  %3 = llvm.add %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem canonicalize_logic_first_xor_0_nswnuw_proof : canonicalize_logic_first_xor_0_nswnuw_before ⊑ canonicalize_logic_first_xor_0_nswnuw_after := by
  unfold canonicalize_logic_first_xor_0_nswnuw_before canonicalize_logic_first_xor_0_nswnuw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN canonicalize_logic_first_xor_0_nswnuw
  apply canonicalize_logic_first_xor_0_nswnuw_thm
  ---END canonicalize_logic_first_xor_0_nswnuw


