import SSA.Projects.InstCombine.tests.LLVM.gxor_proof
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
                                                                       
def test0_before := [llvm|
{
^0(%arg0 : i1):
  %0 = "llvm.mlir.constant"() <{value = 0 : i1}> : () -> i1
  %1 = llvm.xor %arg0, %0 : i1
  "llvm.return"(%1) : (i1) -> ()
}
]
def test0_after := [llvm|
{
^0(%arg0 : i1):
  "llvm.return"(%arg0) : (i1) -> ()
}
]
theorem test0_proof : test0_before ⊑ test0_after := by
  unfold test0_before test0_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test0
  all_goals (try extract_goal ; sorry)
  ---END test0



def test1_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg0 : i32):
  "llvm.return"(%arg0) : (i32) -> ()
}
]
theorem test1_proof : test1_before ⊑ test1_after := by
  unfold test1_before test1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test1
  all_goals (try extract_goal ; sorry)
  ---END test1



def test2_before := [llvm|
{
^0(%arg0 : i1):
  %0 = llvm.xor %arg0, %arg0 : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg0 : i1):
  %0 = "llvm.mlir.constant"() <{value = 0 : i1}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem test2_proof : test2_before ⊑ test2_after := by
  unfold test2_before test2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test2
  all_goals (try extract_goal ; sorry)
  ---END test2



def test3_before := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.xor %arg0, %arg0 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
def test3_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test3_proof : test3_before ⊑ test3_after := by
  unfold test3_before test3_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test3
  all_goals (try extract_goal ; sorry)
  ---END test3



def test4_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %0, %arg0 : i32
  %2 = llvm.xor %arg0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test4_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test4_proof : test4_before ⊑ test4_after := by
  unfold test4_before test4_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test4
  all_goals (try extract_goal ; sorry)
  ---END test4



def test5_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 123 : i32}> : () -> i32
  %1 = llvm.or %arg0, %0 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test5_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = -124 : i32}> : () -> i32
  %1 = llvm.and %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem test5_proof : test5_before ⊑ test5_after := by
  unfold test5_before test5_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test5
  apply test5_thm
  ---END test5



def test6_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 17 : i8}> : () -> i8
  %1 = llvm.xor %arg0, %0 : i8
  %2 = llvm.xor %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def test6_after := [llvm|
{
^0(%arg0 : i8):
  "llvm.return"(%arg0) : (i8) -> ()
}
]
theorem test6_proof : test6_before ⊑ test6_after := by
  unfold test6_before test6_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test6
  all_goals (try extract_goal ; sorry)
  ---END test6



def test7_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 7 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 128 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = llvm.and %arg1, %1 : i32
  %4 = llvm.xor %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test7_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 7 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 128 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = llvm.and %arg1, %1 : i32
  %4 = llvm.or %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem test7_proof : test7_before ⊑ test7_after := by
  unfold test7_before test7_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test7
  apply test7_thm
  ---END test7



def test10_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 4 : i8}> : () -> i8
  %2 = llvm.and %arg0, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def test10_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 4 : i8}> : () -> i8
  %2 = llvm.and %arg0, %0 : i8
  %3 = llvm.or %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem test10_proof : test10_before ⊑ test10_after := by
  unfold test10_before test10_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test10
  apply test10_thm
  ---END test10



def test11_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 12 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 4 : i8}> : () -> i8
  %2 = llvm.or %arg0, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def test11_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = -13 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 8 : i8}> : () -> i8
  %2 = llvm.and %arg0, %0 : i8
  %3 = llvm.or %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem test11_proof : test11_before ⊑ test11_after := by
  unfold test11_before test11_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test11
  apply test11_thm
  ---END test11



def test18_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 123 : i32}> : () -> i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.sub %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test18_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 124 : i32}> : () -> i32
  %1 = llvm.add %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem test18_proof : test18_before ⊑ test18_after := by
  unfold test18_before test18_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test18
  apply test18_thm
  ---END test18



def test19_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.xor %arg0, %arg1 : i32
  %1 = llvm.xor %0, %arg0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
def test19_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  "llvm.return"(%arg1) : (i32) -> ()
}
]
theorem test19_proof : test19_before ⊑ test19_after := by
  unfold test19_before test19_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test19
  all_goals (try extract_goal ; sorry)
  ---END test19



def test25_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %0 : i32
  %2 = llvm.and %1, %arg0 : i32
  %3 = llvm.xor %2, %arg0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test25_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.and %arg1, %arg0 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test25_proof : test25_before ⊑ test25_after := by
  unfold test25_before test25_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test25
  apply test25_thm
  ---END test25



def test28_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = -2147483647 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -2147483648 : i32}> : () -> i32
  %2 = llvm.add %arg0, %0 : i32
  %3 = llvm.xor %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test28_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = llvm.add %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem test28_proof : test28_before ⊑ test28_after := by
  unfold test28_before test28_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test28
  apply test28_thm
  ---END test28



def test28_sub_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = -2147483647 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -2147483648 : i32}> : () -> i32
  %2 = llvm.sub %0, %arg0 : i32
  %3 = llvm.xor %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test28_sub_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = llvm.sub %0, %arg0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem test28_sub_proof : test28_sub_before ⊑ test28_sub_after := by
  unfold test28_sub_before test28_sub_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test28_sub
  apply test28_sub_thm
  ---END test28_sub



def or_or_xor_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = llvm.or %arg2, %arg0 : i4
  %1 = llvm.or %arg2, %arg1 : i4
  %2 = llvm.xor %0, %1 : i4
  "llvm.return"(%2) : (i4) -> ()
}
]
def or_or_xor_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = "llvm.mlir.constant"() <{value = -1 : i4}> : () -> i4
  %1 = llvm.xor %arg2, %0 : i4
  %2 = llvm.xor %arg0, %arg1 : i4
  %3 = llvm.and %2, %1 : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
theorem or_or_xor_proof : or_or_xor_before ⊑ or_or_xor_after := by
  unfold or_or_xor_before or_or_xor_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_or_xor
  apply or_or_xor_thm
  ---END or_or_xor



def or_or_xor_commute1_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = llvm.or %arg0, %arg2 : i4
  %1 = llvm.or %arg2, %arg1 : i4
  %2 = llvm.xor %0, %1 : i4
  "llvm.return"(%2) : (i4) -> ()
}
]
def or_or_xor_commute1_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = "llvm.mlir.constant"() <{value = -1 : i4}> : () -> i4
  %1 = llvm.xor %arg2, %0 : i4
  %2 = llvm.xor %arg0, %arg1 : i4
  %3 = llvm.and %2, %1 : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
theorem or_or_xor_commute1_proof : or_or_xor_commute1_before ⊑ or_or_xor_commute1_after := by
  unfold or_or_xor_commute1_before or_or_xor_commute1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_or_xor_commute1
  apply or_or_xor_commute1_thm
  ---END or_or_xor_commute1



def or_or_xor_commute2_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = llvm.or %arg2, %arg0 : i4
  %1 = llvm.or %arg1, %arg2 : i4
  %2 = llvm.xor %0, %1 : i4
  "llvm.return"(%2) : (i4) -> ()
}
]
def or_or_xor_commute2_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = "llvm.mlir.constant"() <{value = -1 : i4}> : () -> i4
  %1 = llvm.xor %arg2, %0 : i4
  %2 = llvm.xor %arg0, %arg1 : i4
  %3 = llvm.and %2, %1 : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
theorem or_or_xor_commute2_proof : or_or_xor_commute2_before ⊑ or_or_xor_commute2_after := by
  unfold or_or_xor_commute2_before or_or_xor_commute2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_or_xor_commute2
  apply or_or_xor_commute2_thm
  ---END or_or_xor_commute2



def not_is_canonical_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1073741823 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.add %2, %arg1 : i32
  %4 = llvm.shl %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def not_is_canonical_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.add %2, %arg1 : i32
  %4 = llvm.shl %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem not_is_canonical_proof : not_is_canonical_before ⊑ not_is_canonical_after := by
  unfold not_is_canonical_before not_is_canonical_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN not_is_canonical
  apply not_is_canonical_thm
  ---END not_is_canonical



def not_shl_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 7 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = -128 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def not_shl_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 7 : i8}> : () -> i8
  %2 = llvm.xor %arg0, %0 : i8
  %3 = llvm.shl %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem not_shl_proof : not_shl_before ⊑ not_shl_after := by
  unfold not_shl_before not_shl_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN not_shl
  apply not_shl_thm
  ---END not_shl



def not_lshr_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 5 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 7 : i8}> : () -> i8
  %2 = llvm.lshr %arg0, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def not_lshr_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 5 : i8}> : () -> i8
  %2 = llvm.xor %arg0, %0 : i8
  %3 = llvm.lshr %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem not_lshr_proof : not_lshr_before ⊑ not_lshr_after := by
  unfold not_lshr_before not_lshr_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN not_lshr
  apply not_lshr_thm
  ---END not_lshr



def ashr_not_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 5 : i8}> : () -> i8
  %2 = llvm.xor %arg0, %0 : i8
  %3 = llvm.ashr %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def ashr_not_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 5 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %2 = llvm.ashr %arg0, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem ashr_not_proof : ashr_not_before ⊑ ashr_not_after := by
  unfold ashr_not_before ashr_not_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN ashr_not
  apply ashr_not_thm
  ---END ashr_not



def tryFactorization_xor_ashr_lshr_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = -3 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
  %2 = llvm.ashr %0, %arg0 : i32
  %3 = llvm.lshr %1, %arg0 : i32
  %4 = llvm.xor %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def tryFactorization_xor_ashr_lshr_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = -8 : i32}> : () -> i32
  %1 = llvm.ashr %0, %arg0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem tryFactorization_xor_ashr_lshr_proof : tryFactorization_xor_ashr_lshr_before ⊑ tryFactorization_xor_ashr_lshr_after := by
  unfold tryFactorization_xor_ashr_lshr_before tryFactorization_xor_ashr_lshr_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN tryFactorization_xor_ashr_lshr
  apply tryFactorization_xor_ashr_lshr_thm
  ---END tryFactorization_xor_ashr_lshr



def tryFactorization_xor_lshr_ashr_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = -3 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
  %2 = llvm.ashr %0, %arg0 : i32
  %3 = llvm.lshr %1, %arg0 : i32
  %4 = llvm.xor %3, %2 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def tryFactorization_xor_lshr_ashr_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = -8 : i32}> : () -> i32
  %1 = llvm.ashr %0, %arg0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem tryFactorization_xor_lshr_ashr_proof : tryFactorization_xor_lshr_ashr_before ⊑ tryFactorization_xor_lshr_ashr_after := by
  unfold tryFactorization_xor_lshr_ashr_before tryFactorization_xor_lshr_ashr_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN tryFactorization_xor_lshr_ashr
  apply tryFactorization_xor_lshr_ashr_thm
  ---END tryFactorization_xor_lshr_ashr



def tryFactorization_xor_lshr_lshr_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = -3 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
  %2 = llvm.lshr %0, %arg0 : i32
  %3 = llvm.lshr %1, %arg0 : i32
  %4 = llvm.xor %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def tryFactorization_xor_lshr_lshr_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = -8 : i32}> : () -> i32
  %1 = llvm.lshr %0, %arg0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem tryFactorization_xor_lshr_lshr_proof : tryFactorization_xor_lshr_lshr_before ⊑ tryFactorization_xor_lshr_lshr_after := by
  unfold tryFactorization_xor_lshr_lshr_before tryFactorization_xor_lshr_lshr_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN tryFactorization_xor_lshr_lshr
  apply tryFactorization_xor_lshr_lshr_thm
  ---END tryFactorization_xor_lshr_lshr



def tryFactorization_xor_ashr_ashr_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = -3 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -5 : i32}> : () -> i32
  %2 = llvm.ashr %0, %arg0 : i32
  %3 = llvm.ashr %1, %arg0 : i32
  %4 = llvm.xor %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def tryFactorization_xor_ashr_ashr_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 6 : i32}> : () -> i32
  %1 = llvm.lshr %0, %arg0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem tryFactorization_xor_ashr_ashr_proof : tryFactorization_xor_ashr_ashr_before ⊑ tryFactorization_xor_ashr_ashr_after := by
  unfold tryFactorization_xor_ashr_ashr_before tryFactorization_xor_ashr_ashr_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN tryFactorization_xor_ashr_ashr
  apply tryFactorization_xor_ashr_ashr_thm
  ---END tryFactorization_xor_ashr_ashr



def PR96857_xor_with_noundef_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = "llvm.mlir.constant"() <{value = -1 : i4}> : () -> i4
  %1 = llvm.and %arg2, %arg0 : i4
  %2 = llvm.xor %arg2, %0 : i4
  %3 = llvm.and %2, %arg1 : i4
  %4 = llvm.xor %1, %3 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def PR96857_xor_with_noundef_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = "llvm.mlir.constant"() <{value = -1 : i4}> : () -> i4
  %1 = llvm.and %arg2, %arg0 : i4
  %2 = llvm.xor %arg2, %0 : i4
  %3 = llvm.and %2, %arg1 : i4
  %4 = llvm.or %1, %3 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
theorem PR96857_xor_with_noundef_proof : PR96857_xor_with_noundef_before ⊑ PR96857_xor_with_noundef_after := by
  unfold PR96857_xor_with_noundef_before PR96857_xor_with_noundef_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN PR96857_xor_with_noundef
  apply PR96857_xor_with_noundef_thm
  ---END PR96857_xor_with_noundef



def PR96857_xor_without_noundef_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = "llvm.mlir.constant"() <{value = -1 : i4}> : () -> i4
  %1 = llvm.and %arg2, %arg0 : i4
  %2 = llvm.xor %arg2, %0 : i4
  %3 = llvm.and %2, %arg1 : i4
  %4 = llvm.xor %1, %3 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def PR96857_xor_without_noundef_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = "llvm.mlir.constant"() <{value = -1 : i4}> : () -> i4
  %1 = llvm.and %arg2, %arg0 : i4
  %2 = llvm.xor %arg2, %0 : i4
  %3 = llvm.and %2, %arg1 : i4
  %4 = llvm.or %1, %3 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
theorem PR96857_xor_without_noundef_proof : PR96857_xor_without_noundef_before ⊑ PR96857_xor_without_noundef_after := by
  unfold PR96857_xor_without_noundef_before PR96857_xor_without_noundef_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN PR96857_xor_without_noundef
  apply PR96857_xor_without_noundef_thm
  ---END PR96857_xor_without_noundef


