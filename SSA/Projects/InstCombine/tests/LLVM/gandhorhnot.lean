import SSA.Projects.InstCombine.tests.LLVM.gandhorhnot_proof
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
                                                                       
def and_to_xor1_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.or %arg0, %arg1 : i32
  %2 = llvm.and %arg0, %arg1 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.and %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def and_to_xor1_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.xor %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem and_to_xor1_proof : and_to_xor1_before ⊑ and_to_xor1_after := by
  unfold and_to_xor1_before and_to_xor1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN and_to_xor1
  apply and_to_xor1_thm
  ---END and_to_xor1



def and_to_xor2_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.or %arg0, %arg1 : i32
  %2 = llvm.and %arg0, %arg1 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def and_to_xor2_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.xor %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem and_to_xor2_proof : and_to_xor2_before ⊑ and_to_xor2_after := by
  unfold and_to_xor2_before and_to_xor2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN and_to_xor2
  apply and_to_xor2_thm
  ---END and_to_xor2



def and_to_xor3_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.or %arg0, %arg1 : i32
  %2 = llvm.and %arg1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.and %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def and_to_xor3_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.xor %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem and_to_xor3_proof : and_to_xor3_before ⊑ and_to_xor3_after := by
  unfold and_to_xor3_before and_to_xor3_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN and_to_xor3
  apply and_to_xor3_thm
  ---END and_to_xor3



def and_to_xor4_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.or %arg1, %arg0 : i32
  %2 = llvm.and %arg0, %arg1 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def and_to_xor4_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.xor %arg1, %arg0 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem and_to_xor4_proof : and_to_xor4_before ⊑ and_to_xor4_after := by
  unfold and_to_xor4_before and_to_xor4_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN and_to_xor4
  apply and_to_xor4_thm
  ---END and_to_xor4



def or_to_nxor1_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = llvm.or %arg0, %arg1 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.or %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def or_to_nxor1_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem or_to_nxor1_proof : or_to_nxor1_before ⊑ or_to_nxor1_after := by
  unfold or_to_nxor1_before or_to_nxor1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_to_nxor1
  apply or_to_nxor1_thm
  ---END or_to_nxor1



def or_to_nxor2_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = llvm.or %arg1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.or %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def or_to_nxor2_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem or_to_nxor2_proof : or_to_nxor2_before ⊑ or_to_nxor2_after := by
  unfold or_to_nxor2_before or_to_nxor2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_to_nxor2
  apply or_to_nxor2_thm
  ---END or_to_nxor2



def or_to_nxor3_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = llvm.or %arg0, %arg1 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.or %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def or_to_nxor3_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem or_to_nxor3_proof : or_to_nxor3_before ⊑ or_to_nxor3_after := by
  unfold or_to_nxor3_before or_to_nxor3_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_to_nxor3
  apply or_to_nxor3_thm
  ---END or_to_nxor3



def or_to_nxor4_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg1, %arg0 : i32
  %2 = llvm.or %arg0, %arg1 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.or %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def or_to_nxor4_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem or_to_nxor4_proof : or_to_nxor4_before ⊑ or_to_nxor4_after := by
  unfold or_to_nxor4_before or_to_nxor4_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_to_nxor4
  apply or_to_nxor4_thm
  ---END or_to_nxor4



def xor_to_xor1_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.and %arg0, %arg1 : i32
  %1 = llvm.or %arg0, %arg1 : i32
  %2 = llvm.xor %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def xor_to_xor1_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.xor %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem xor_to_xor1_proof : xor_to_xor1_before ⊑ xor_to_xor1_after := by
  unfold xor_to_xor1_before xor_to_xor1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN xor_to_xor1
  all_goals (try extract_goal ; sorry)
  ---END xor_to_xor1



def xor_to_xor2_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.and %arg0, %arg1 : i32
  %1 = llvm.or %arg1, %arg0 : i32
  %2 = llvm.xor %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def xor_to_xor2_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.xor %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem xor_to_xor2_proof : xor_to_xor2_before ⊑ xor_to_xor2_after := by
  unfold xor_to_xor2_before xor_to_xor2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN xor_to_xor2
  all_goals (try extract_goal ; sorry)
  ---END xor_to_xor2



def xor_to_xor3_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.or %arg0, %arg1 : i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = llvm.xor %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def xor_to_xor3_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.xor %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem xor_to_xor3_proof : xor_to_xor3_before ⊑ xor_to_xor3_after := by
  unfold xor_to_xor3_before xor_to_xor3_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN xor_to_xor3
  all_goals (try extract_goal ; sorry)
  ---END xor_to_xor3



def xor_to_xor4_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.or %arg0, %arg1 : i32
  %1 = llvm.and %arg1, %arg0 : i32
  %2 = llvm.xor %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def xor_to_xor4_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.xor %arg1, %arg0 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem xor_to_xor4_proof : xor_to_xor4_before ⊑ xor_to_xor4_after := by
  unfold xor_to_xor4_before xor_to_xor4_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN xor_to_xor4
  all_goals (try extract_goal ; sorry)
  ---END xor_to_xor4



def simplify_or_common_op_commute0_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = "llvm.mlir.constant"() <{value = -1 : i4}> : () -> i4
  %1 = llvm.and %arg0, %arg1 : i4
  %2 = llvm.and %1, %arg2 : i4
  %3 = llvm.xor %2, %0 : i4
  %4 = llvm.or %3, %arg0 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def simplify_or_common_op_commute0_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = "llvm.mlir.constant"() <{value = -1 : i4}> : () -> i4
  "llvm.return"(%0) : (i4) -> ()
}
]
theorem simplify_or_common_op_commute0_proof : simplify_or_common_op_commute0_before ⊑ simplify_or_common_op_commute0_after := by
  unfold simplify_or_common_op_commute0_before simplify_or_common_op_commute0_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN simplify_or_common_op_commute0
  apply simplify_or_common_op_commute0_thm
  ---END simplify_or_common_op_commute0



def simplify_or_common_op_commute1_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = "llvm.mlir.constant"() <{value = -1 : i4}> : () -> i4
  %1 = llvm.and %arg1, %arg0 : i4
  %2 = llvm.and %1, %arg2 : i4
  %3 = llvm.xor %2, %0 : i4
  %4 = llvm.or %3, %arg0 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def simplify_or_common_op_commute1_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = "llvm.mlir.constant"() <{value = -1 : i4}> : () -> i4
  "llvm.return"(%0) : (i4) -> ()
}
]
theorem simplify_or_common_op_commute1_proof : simplify_or_common_op_commute1_before ⊑ simplify_or_common_op_commute1_after := by
  unfold simplify_or_common_op_commute1_before simplify_or_common_op_commute1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN simplify_or_common_op_commute1
  apply simplify_or_common_op_commute1_thm
  ---END simplify_or_common_op_commute1



def simplify_or_common_op_commute2_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4, %arg3 : i4):
  %0 = "llvm.mlir.constant"() <{value = -1 : i4}> : () -> i4
  %1 = llvm.mul %arg2, %arg2 : i4
  %2 = llvm.and %arg0, %arg1 : i4
  %3 = llvm.and %1, %2 : i4
  %4 = llvm.and %3, %arg3 : i4
  %5 = llvm.xor %4, %0 : i4
  %6 = llvm.or %5, %arg0 : i4
  "llvm.return"(%6) : (i4) -> ()
}
]
def simplify_or_common_op_commute2_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4, %arg3 : i4):
  %0 = "llvm.mlir.constant"() <{value = -1 : i4}> : () -> i4
  "llvm.return"(%0) : (i4) -> ()
}
]
theorem simplify_or_common_op_commute2_proof : simplify_or_common_op_commute2_before ⊑ simplify_or_common_op_commute2_after := by
  unfold simplify_or_common_op_commute2_before simplify_or_common_op_commute2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN simplify_or_common_op_commute2
  apply simplify_or_common_op_commute2_thm
  ---END simplify_or_common_op_commute2



def simplify_and_common_op_commute1_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = "llvm.mlir.constant"() <{value = -1 : i4}> : () -> i4
  %1 = llvm.or %arg1, %arg0 : i4
  %2 = llvm.or %1, %arg2 : i4
  %3 = llvm.xor %2, %0 : i4
  %4 = llvm.and %3, %arg0 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def simplify_and_common_op_commute1_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = "llvm.mlir.constant"() <{value = 0 : i4}> : () -> i4
  "llvm.return"(%0) : (i4) -> ()
}
]
theorem simplify_and_common_op_commute1_proof : simplify_and_common_op_commute1_before ⊑ simplify_and_common_op_commute1_after := by
  unfold simplify_and_common_op_commute1_before simplify_and_common_op_commute1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN simplify_and_common_op_commute1
  apply simplify_and_common_op_commute1_thm
  ---END simplify_and_common_op_commute1



def simplify_and_common_op_commute2_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4, %arg3 : i4):
  %0 = "llvm.mlir.constant"() <{value = -1 : i4}> : () -> i4
  %1 = llvm.mul %arg2, %arg2 : i4
  %2 = llvm.or %arg0, %arg1 : i4
  %3 = llvm.or %1, %2 : i4
  %4 = llvm.or %3, %arg3 : i4
  %5 = llvm.xor %4, %0 : i4
  %6 = llvm.and %5, %arg0 : i4
  "llvm.return"(%6) : (i4) -> ()
}
]
def simplify_and_common_op_commute2_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4, %arg3 : i4):
  %0 = "llvm.mlir.constant"() <{value = 0 : i4}> : () -> i4
  "llvm.return"(%0) : (i4) -> ()
}
]
theorem simplify_and_common_op_commute2_proof : simplify_and_common_op_commute2_before ⊑ simplify_and_common_op_commute2_after := by
  unfold simplify_and_common_op_commute2_before simplify_and_common_op_commute2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN simplify_and_common_op_commute2
  apply simplify_and_common_op_commute2_thm
  ---END simplify_and_common_op_commute2



def reduce_xor_common_op_commute0_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = llvm.xor %arg0, %arg1 : i4
  %1 = llvm.xor %0, %arg2 : i4
  %2 = llvm.or %1, %arg0 : i4
  "llvm.return"(%2) : (i4) -> ()
}
]
def reduce_xor_common_op_commute0_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = llvm.xor %arg1, %arg2 : i4
  %1 = llvm.or %0, %arg0 : i4
  "llvm.return"(%1) : (i4) -> ()
}
]
theorem reduce_xor_common_op_commute0_proof : reduce_xor_common_op_commute0_before ⊑ reduce_xor_common_op_commute0_after := by
  unfold reduce_xor_common_op_commute0_before reduce_xor_common_op_commute0_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN reduce_xor_common_op_commute0
  all_goals (try extract_goal ; sorry)
  ---END reduce_xor_common_op_commute0



def reduce_xor_common_op_commute1_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = llvm.xor %arg1, %arg0 : i4
  %1 = llvm.xor %0, %arg2 : i4
  %2 = llvm.or %1, %arg0 : i4
  "llvm.return"(%2) : (i4) -> ()
}
]
def reduce_xor_common_op_commute1_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = llvm.xor %arg1, %arg2 : i4
  %1 = llvm.or %0, %arg0 : i4
  "llvm.return"(%1) : (i4) -> ()
}
]
theorem reduce_xor_common_op_commute1_proof : reduce_xor_common_op_commute1_before ⊑ reduce_xor_common_op_commute1_after := by
  unfold reduce_xor_common_op_commute1_before reduce_xor_common_op_commute1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN reduce_xor_common_op_commute1
  all_goals (try extract_goal ; sorry)
  ---END reduce_xor_common_op_commute1



def annihilate_xor_common_op_commute2_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4, %arg3 : i4):
  %0 = llvm.mul %arg2, %arg2 : i4
  %1 = llvm.xor %arg0, %arg1 : i4
  %2 = llvm.xor %0, %1 : i4
  %3 = llvm.xor %2, %arg3 : i4
  %4 = llvm.xor %3, %arg0 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def annihilate_xor_common_op_commute2_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4, %arg3 : i4):
  %0 = llvm.mul %arg2, %arg2 : i4
  %1 = llvm.xor %0, %arg1 : i4
  %2 = llvm.xor %1, %arg3 : i4
  "llvm.return"(%2) : (i4) -> ()
}
]
theorem annihilate_xor_common_op_commute2_proof : annihilate_xor_common_op_commute2_before ⊑ annihilate_xor_common_op_commute2_after := by
  unfold annihilate_xor_common_op_commute2_before annihilate_xor_common_op_commute2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN annihilate_xor_common_op_commute2
  all_goals (try extract_goal ; sorry)
  ---END annihilate_xor_common_op_commute2


