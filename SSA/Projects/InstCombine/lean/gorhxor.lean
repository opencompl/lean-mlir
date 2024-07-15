import SSA.Projects.InstCombine.lean.gorhxor_proof
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
                                                                       
def test1_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.or %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %arg0, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %0 : i32
  %2 = llvm.or %1, %arg0 : i32
  "llvm.return"(%2) : (i32) -> ()
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
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.or %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %arg1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.or %1, %arg1 : i32
  "llvm.return"(%2) : (i32) -> ()
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
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %arg0, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test3_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %0 : i32
  %2 = llvm.or %1, %arg0 : i32
  "llvm.return"(%2) : (i32) -> ()
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
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %arg1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test4_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.or %1, %arg1 : i32
  "llvm.return"(%2) : (i32) -> ()
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
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %arg1 : i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.or %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test5_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
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



def test5_commuted_x_y_before := [llvm|
{
^0(%arg0 : i64, %arg1 : i64):
  %0 = "llvm.mlir.constant"() <{value = -1 : i64}> : () -> i64
  %1 = llvm.xor %arg1, %arg0 : i64
  %2 = llvm.xor %arg0, %0 : i64
  %3 = llvm.or %1, %2 : i64
  "llvm.return"(%3) : (i64) -> ()
}
]
def test5_commuted_x_y_after := [llvm|
{
^0(%arg0 : i64, %arg1 : i64):
  %0 = "llvm.mlir.constant"() <{value = -1 : i64}> : () -> i64
  %1 = llvm.and %arg1, %arg0 : i64
  %2 = llvm.xor %1, %0 : i64
  "llvm.return"(%2) : (i64) -> ()
}
]
theorem test5_commuted_x_y_proof : test5_commuted_x_y_before ⊑ test5_commuted_x_y_after := by
  unfold test5_commuted_x_y_before test5_commuted_x_y_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test5_commuted_x_y
  apply test5_commuted_x_y_thm
  ---END test5_commuted_x_y



def xor_common_op_commute0_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.xor %arg0, %arg1 : i8
  %1 = llvm.or %0, %arg0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def xor_common_op_commute0_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.or %arg0, %arg1 : i8
  "llvm.return"(%0) : (i8) -> ()
}
]
theorem xor_common_op_commute0_proof : xor_common_op_commute0_before ⊑ xor_common_op_commute0_after := by
  unfold xor_common_op_commute0_before xor_common_op_commute0_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN xor_common_op_commute0
  all_goals (try extract_goal ; sorry)
  ---END xor_common_op_commute0



def xor_common_op_commute2_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 5 : i8}> : () -> i8
  %1 = llvm.xor %arg0, %0 : i8
  %2 = llvm.xor %1, %arg1 : i8
  %3 = llvm.or %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def xor_common_op_commute2_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 5 : i8}> : () -> i8
  %1 = llvm.xor %arg0, %0 : i8
  %2 = llvm.or %1, %arg1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem xor_common_op_commute2_proof : xor_common_op_commute2_before ⊑ xor_common_op_commute2_after := by
  unfold xor_common_op_commute2_before xor_common_op_commute2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN xor_common_op_commute2
  all_goals (try extract_goal ; sorry)
  ---END xor_common_op_commute2



def xor_common_op_commute3_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 5 : i8}> : () -> i8
  %1 = llvm.xor %arg0, %0 : i8
  %2 = llvm.mul %arg1, %arg1 : i8
  %3 = llvm.xor %2, %1 : i8
  %4 = llvm.or %1, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def xor_common_op_commute3_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 5 : i8}> : () -> i8
  %1 = llvm.xor %arg0, %0 : i8
  %2 = llvm.mul %arg1, %arg1 : i8
  %3 = llvm.or %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem xor_common_op_commute3_proof : xor_common_op_commute3_before ⊑ xor_common_op_commute3_after := by
  unfold xor_common_op_commute3_before xor_common_op_commute3_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN xor_common_op_commute3
  all_goals (try extract_goal ; sorry)
  ---END xor_common_op_commute3



def test8_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %0 : i32
  %2 = llvm.xor %arg0, %1 : i32
  %3 = llvm.or %arg1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test8_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.or %1, %arg1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem test8_proof : test8_before ⊑ test8_after := by
  unfold test8_before test8_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test8
  all_goals (try extract_goal ; sorry)
  ---END test8



def test9_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.xor %1, %arg1 : i32
  %3 = llvm.or %arg0, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test9_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %0 : i32
  %2 = llvm.or %1, %arg0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem test9_proof : test9_before ⊑ test9_after := by
  unfold test9_before test9_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test9
  all_goals (try extract_goal ; sorry)
  ---END test9



def test10_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %arg0 : i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.xor %2, %arg1 : i32
  %4 = llvm.or %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test10_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %arg0 : i32
  %2 = llvm.xor %arg0, %arg1 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.or %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
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
  all_goals (try extract_goal ; sorry)
  ---END test10



def test10_commuted_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %arg0 : i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.xor %2, %arg1 : i32
  %4 = llvm.or %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test10_commuted_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %arg0 : i32
  %2 = llvm.xor %arg0, %arg1 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.or %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem test10_commuted_proof : test10_commuted_before ⊑ test10_commuted_after := by
  unfold test10_commuted_before test10_commuted_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test10_commuted
  all_goals (try extract_goal ; sorry)
  ---END test10_commuted



def test11_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.or %arg0, %arg1 : i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.xor %2, %arg1 : i32
  %4 = llvm.and %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test11_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.and %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
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



def test12_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.xor %1, %arg1 : i32
  %3 = llvm.or %arg0, %arg1 : i32
  %4 = llvm.and %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test12_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.and %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test12_proof : test12_before ⊑ test12_after := by
  unfold test12_before test12_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test12
  apply test12_thm
  ---END test12



def test12_commuted_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.xor %1, %arg1 : i32
  %3 = llvm.or %arg1, %arg0 : i32
  %4 = llvm.and %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test12_commuted_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.and %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test12_commuted_proof : test12_commuted_before ⊑ test12_commuted_after := by
  unfold test12_commuted_before test12_commuted_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test12_commuted
  apply test12_commuted_thm
  ---END test12_commuted



def test13_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.xor %arg1, %arg0 : i32
  %1 = llvm.or %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test13_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.and %arg1, %arg0 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test13_proof : test13_before ⊑ test13_after := by
  unfold test13_before test13_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test13
  all_goals (try extract_goal ; sorry)
  ---END test13



def test14_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %0 : i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.or %arg0, %1 : i32
  %4 = llvm.or %2, %arg1 : i32
  %5 = llvm.xor %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test14_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.xor %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test14_proof : test14_before ⊑ test14_after := by
  unfold test14_before test14_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test14
  apply test14_thm
  ---END test14



def test14_commuted_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %0 : i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.or %1, %arg0 : i32
  %4 = llvm.or %2, %arg1 : i32
  %5 = llvm.xor %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test14_commuted_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.xor %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test14_commuted_proof : test14_commuted_before ⊑ test14_commuted_after := by
  unfold test14_commuted_before test14_commuted_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test14_commuted
  apply test14_commuted_thm
  ---END test14_commuted



def test15_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %0 : i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.and %arg0, %1 : i32
  %4 = llvm.and %2, %arg1 : i32
  %5 = llvm.xor %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test15_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.xor %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test15_proof : test15_before ⊑ test15_after := by
  unfold test15_before test15_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test15
  apply test15_thm
  ---END test15



def test15_commuted_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %0 : i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.and %1, %arg0 : i32
  %4 = llvm.and %2, %arg1 : i32
  %5 = llvm.xor %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test15_commuted_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.xor %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test15_commuted_proof : test15_commuted_before ⊑ test15_commuted_after := by
  unfold test15_commuted_before test15_commuted_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test15_commuted
  apply test15_commuted_thm
  ---END test15_commuted



def or_and_xor_not_constant_commute0_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -2 : i32}> : () -> i32
  %2 = llvm.xor %arg0, %arg1 : i32
  %3 = llvm.and %2, %0 : i32
  %4 = llvm.and %arg1, %1 : i32
  %5 = llvm.or %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def or_and_xor_not_constant_commute0_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = llvm.and %arg0, %0 : i32
  %2 = llvm.xor %1, %arg1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem or_and_xor_not_constant_commute0_proof : or_and_xor_not_constant_commute0_before ⊑ or_and_xor_not_constant_commute0_after := by
  unfold or_and_xor_not_constant_commute0_before or_and_xor_not_constant_commute0_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_and_xor_not_constant_commute0
  apply or_and_xor_not_constant_commute0_thm
  ---END or_and_xor_not_constant_commute0



def or_and_xor_not_constant_commute1_before := [llvm|
{
^0(%arg0 : i9, %arg1 : i9):
  %0 = "llvm.mlir.constant"() <{value = 42 : i9}> : () -> i9
  %1 = "llvm.mlir.constant"() <{value = -43 : i9}> : () -> i9
  %2 = llvm.xor %arg1, %arg0 : i9
  %3 = llvm.and %2, %0 : i9
  %4 = llvm.and %arg1, %1 : i9
  %5 = llvm.or %3, %4 : i9
  "llvm.return"(%5) : (i9) -> ()
}
]
def or_and_xor_not_constant_commute1_after := [llvm|
{
^0(%arg0 : i9, %arg1 : i9):
  %0 = "llvm.mlir.constant"() <{value = 42 : i9}> : () -> i9
  %1 = llvm.and %arg0, %0 : i9
  %2 = llvm.xor %1, %arg1 : i9
  "llvm.return"(%2) : (i9) -> ()
}
]
theorem or_and_xor_not_constant_commute1_proof : or_and_xor_not_constant_commute1_before ⊑ or_and_xor_not_constant_commute1_after := by
  unfold or_and_xor_not_constant_commute1_before or_and_xor_not_constant_commute1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_and_xor_not_constant_commute1
  apply or_and_xor_not_constant_commute1_thm
  ---END or_and_xor_not_constant_commute1



def not_or_xor_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 7 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{value = 12 : i8}> : () -> i8
  %3 = llvm.xor %arg0, %0 : i8
  %4 = llvm.or %3, %1 : i8
  %5 = llvm.xor %4, %2 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def not_or_xor_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = -8 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = -13 : i8}> : () -> i8
  %2 = llvm.and %arg0, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem not_or_xor_proof : not_or_xor_before ⊑ not_or_xor_after := by
  unfold not_or_xor_before not_or_xor_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN not_or_xor
  apply not_or_xor_thm
  ---END not_or_xor



def xor_or_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 32 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 7 : i8}> : () -> i8
  %2 = llvm.xor %arg0, %0 : i8
  %3 = llvm.or %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def xor_or_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = -8 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 39 : i8}> : () -> i8
  %2 = llvm.and %arg0, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem xor_or_proof : xor_or_before ⊑ xor_or_after := by
  unfold xor_or_before xor_or_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN xor_or
  apply xor_or_thm
  ---END xor_or



def xor_or2_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 33 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 7 : i8}> : () -> i8
  %2 = llvm.xor %arg0, %0 : i8
  %3 = llvm.or %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def xor_or2_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = -8 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 39 : i8}> : () -> i8
  %2 = llvm.and %arg0, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem xor_or2_proof : xor_or2_before ⊑ xor_or2_after := by
  unfold xor_or2_before xor_or2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN xor_or2
  apply xor_or2_thm
  ---END xor_or2



def xor_or_xor_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 33 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 7 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{value = 12 : i8}> : () -> i8
  %3 = llvm.xor %arg0, %0 : i8
  %4 = llvm.or %3, %1 : i8
  %5 = llvm.xor %4, %2 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def xor_or_xor_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = -8 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 43 : i8}> : () -> i8
  %2 = llvm.and %arg0, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem xor_or_xor_proof : xor_or_xor_before ⊑ xor_or_xor_after := by
  unfold xor_or_xor_before xor_or_xor_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN xor_or_xor
  apply xor_or_xor_thm
  ---END xor_or_xor



def or_xor_or_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 33 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 12 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{value = 7 : i8}> : () -> i8
  %3 = llvm.or %arg0, %0 : i8
  %4 = llvm.xor %3, %1 : i8
  %5 = llvm.or %4, %2 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def or_xor_or_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = -40 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 47 : i8}> : () -> i8
  %2 = llvm.and %arg0, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem or_xor_or_proof : or_xor_or_before ⊑ or_xor_or_after := by
  unfold or_xor_or_before or_xor_or_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_xor_or
  apply or_xor_or_thm
  ---END or_xor_or



def test17_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 33 : i8}> : () -> i8
  %1 = llvm.xor %arg1, %arg0 : i8
  %2 = llvm.xor %arg0, %0 : i8
  %3 = llvm.xor %2, %arg1 : i8
  %4 = llvm.or %1, %3 : i8
  %5 = llvm.mul %4, %3 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def test17_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 33 : i8}> : () -> i8
  %1 = llvm.xor %arg1, %arg0 : i8
  %2 = llvm.xor %arg0, %arg1 : i8
  %3 = llvm.xor %2, %0 : i8
  %4 = llvm.or %1, %3 : i8
  %5 = llvm.mul %4, %3 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
theorem test17_proof : test17_before ⊑ test17_after := by
  unfold test17_before test17_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test17
  apply test17_thm
  ---END test17



def test18_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 33 : i8}> : () -> i8
  %1 = llvm.xor %arg1, %arg0 : i8
  %2 = llvm.xor %arg0, %0 : i8
  %3 = llvm.xor %2, %arg1 : i8
  %4 = llvm.or %3, %1 : i8
  %5 = llvm.mul %4, %3 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def test18_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 33 : i8}> : () -> i8
  %1 = llvm.xor %arg1, %arg0 : i8
  %2 = llvm.xor %arg0, %arg1 : i8
  %3 = llvm.xor %2, %0 : i8
  %4 = llvm.or %3, %1 : i8
  %5 = llvm.mul %4, %3 : i8
  "llvm.return"(%5) : (i8) -> ()
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
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %0 : i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.or %arg0, %arg1 : i32
  %4 = llvm.or %2, %1 : i32
  %5 = llvm.xor %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test19_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
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
  apply test19_thm
  ---END test19



def test20_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %0 : i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.or %arg0, %arg1 : i32
  %4 = llvm.or %1, %2 : i32
  %5 = llvm.xor %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test20_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem test20_proof : test20_before ⊑ test20_after := by
  unfold test20_before test20_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test20
  apply test20_thm
  ---END test20



def test21_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %0 : i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.or %2, %1 : i32
  %4 = llvm.or %arg0, %arg1 : i32
  %5 = llvm.xor %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test21_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem test21_proof : test21_before ⊑ test21_after := by
  unfold test21_before test21_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test21
  apply test21_thm
  ---END test21



def test22_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %0 : i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.or %2, %1 : i32
  %4 = llvm.or %arg1, %arg0 : i32
  %5 = llvm.xor %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test22_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem test22_proof : test22_before ⊑ test22_after := by
  unfold test22_before test22_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test22
  apply test22_thm
  ---END test22



def test23_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = -2 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 13 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %3 = "llvm.mlir.constant"() <{value = 12 : i8}> : () -> i8
  %4 = llvm.or %arg0, %0 : i8
  %5 = llvm.xor %4, %1 : i8
  %6 = llvm.or %5, %2 : i8
  %7 = llvm.xor %6, %3 : i8
  "llvm.return"(%7) : (i8) -> ()
}
]
def test23_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  "llvm.return"(%0) : (i8) -> ()
}
]
theorem test23_proof : test23_before ⊑ test23_after := by
  unfold test23_before test23_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test23
  apply test23_thm
  ---END test23



def PR45977_f1_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.and %1, %arg1 : i32
  %3 = llvm.or %arg0, %arg1 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.or %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def PR45977_f1_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem PR45977_f1_proof : PR45977_f1_before ⊑ PR45977_f1_after := by
  unfold PR45977_f1_before PR45977_f1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN PR45977_f1
  apply PR45977_f1_thm
  ---END PR45977_f1



def PR45977_f2_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.or %arg0, %arg1 : i32
  %2 = llvm.xor %arg1, %0 : i32
  %3 = llvm.or %arg0, %2 : i32
  %4 = llvm.xor %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def PR45977_f2_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem PR45977_f2_proof : PR45977_f2_before ⊑ PR45977_f2_after := by
  unfold PR45977_f2_before PR45977_f2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN PR45977_f2
  apply PR45977_f2_thm
  ---END PR45977_f2



def or_xor_common_op_commute0_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.or %arg0, %arg1 : i8
  %1 = llvm.xor %arg0, %arg2 : i8
  %2 = llvm.or %0, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def or_xor_common_op_commute0_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.or %arg0, %arg1 : i8
  %1 = llvm.or %0, %arg2 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem or_xor_common_op_commute0_proof : or_xor_common_op_commute0_before ⊑ or_xor_common_op_commute0_after := by
  unfold or_xor_common_op_commute0_before or_xor_common_op_commute0_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_xor_common_op_commute0
  all_goals (try extract_goal ; sorry)
  ---END or_xor_common_op_commute0



def or_xor_common_op_commute5_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.or %arg1, %arg0 : i8
  %1 = llvm.xor %arg0, %arg2 : i8
  %2 = llvm.or %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def or_xor_common_op_commute5_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.or %arg1, %arg0 : i8
  %1 = llvm.or %0, %arg2 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem or_xor_common_op_commute5_proof : or_xor_common_op_commute5_before ⊑ or_xor_common_op_commute5_after := by
  unfold or_xor_common_op_commute5_before or_xor_common_op_commute5_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_xor_common_op_commute5
  all_goals (try extract_goal ; sorry)
  ---END or_xor_common_op_commute5



def or_xor_common_op_commute6_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.or %arg0, %arg1 : i8
  %1 = llvm.xor %arg2, %arg0 : i8
  %2 = llvm.or %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def or_xor_common_op_commute6_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.or %arg0, %arg1 : i8
  %1 = llvm.or %0, %arg2 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem or_xor_common_op_commute6_proof : or_xor_common_op_commute6_before ⊑ or_xor_common_op_commute6_after := by
  unfold or_xor_common_op_commute6_before or_xor_common_op_commute6_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_xor_common_op_commute6
  all_goals (try extract_goal ; sorry)
  ---END or_xor_common_op_commute6



def or_xor_common_op_commute7_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.or %arg1, %arg0 : i8
  %1 = llvm.xor %arg2, %arg0 : i8
  %2 = llvm.or %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def or_xor_common_op_commute7_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.or %arg1, %arg0 : i8
  %1 = llvm.or %0, %arg2 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem or_xor_common_op_commute7_proof : or_xor_common_op_commute7_before ⊑ or_xor_common_op_commute7_after := by
  unfold or_xor_common_op_commute7_before or_xor_common_op_commute7_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_xor_common_op_commute7
  all_goals (try extract_goal ; sorry)
  ---END or_xor_common_op_commute7



def or_not_xor_common_op_commute0_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = "llvm.mlir.constant"() <{value = -1 : i4}> : () -> i4
  %1 = llvm.xor %arg0, %0 : i4
  %2 = llvm.xor %arg0, %arg1 : i4
  %3 = llvm.or %1, %arg2 : i4
  %4 = llvm.or %3, %2 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def or_not_xor_common_op_commute0_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = "llvm.mlir.constant"() <{value = -1 : i4}> : () -> i4
  %1 = llvm.and %arg0, %arg1 : i4
  %2 = llvm.xor %1, %0 : i4
  %3 = llvm.or %2, %arg2 : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
theorem or_not_xor_common_op_commute0_proof : or_not_xor_common_op_commute0_before ⊑ or_not_xor_common_op_commute0_after := by
  unfold or_not_xor_common_op_commute0_before or_not_xor_common_op_commute0_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_not_xor_common_op_commute0
  apply or_not_xor_common_op_commute0_thm
  ---END or_not_xor_common_op_commute0



def or_not_xor_common_op_commute2_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %2 = llvm.sub %0, %arg2 : i8
  %3 = llvm.xor %arg0, %1 : i8
  %4 = llvm.xor %arg0, %arg1 : i8
  %5 = llvm.or %2, %3 : i8
  %6 = llvm.or %4, %5 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def or_not_xor_common_op_commute2_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %2 = llvm.sub %0, %arg2 : i8
  %3 = llvm.and %arg0, %arg1 : i8
  %4 = llvm.xor %3, %1 : i8
  %5 = llvm.or %4, %2 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
theorem or_not_xor_common_op_commute2_proof : or_not_xor_common_op_commute2_before ⊑ or_not_xor_common_op_commute2_after := by
  unfold or_not_xor_common_op_commute2_before or_not_xor_common_op_commute2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_not_xor_common_op_commute2
  apply or_not_xor_common_op_commute2_thm
  ---END or_not_xor_common_op_commute2



def or_not_xor_common_op_commute3_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %2 = llvm.sub %0, %arg2 : i8
  %3 = llvm.xor %arg0, %1 : i8
  %4 = llvm.xor %arg0, %arg1 : i8
  %5 = llvm.or %2, %3 : i8
  %6 = llvm.or %5, %4 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def or_not_xor_common_op_commute3_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %2 = llvm.sub %0, %arg2 : i8
  %3 = llvm.and %arg0, %arg1 : i8
  %4 = llvm.xor %3, %1 : i8
  %5 = llvm.or %4, %2 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
theorem or_not_xor_common_op_commute3_proof : or_not_xor_common_op_commute3_before ⊑ or_not_xor_common_op_commute3_after := by
  unfold or_not_xor_common_op_commute3_before or_not_xor_common_op_commute3_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_not_xor_common_op_commute3
  apply or_not_xor_common_op_commute3_thm
  ---END or_not_xor_common_op_commute3



def or_not_xor_common_op_commute5_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = llvm.xor %arg0, %0 : i8
  %2 = llvm.xor %arg1, %arg0 : i8
  %3 = llvm.or %1, %arg2 : i8
  %4 = llvm.or %2, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def or_not_xor_common_op_commute5_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = llvm.and %arg1, %arg0 : i8
  %2 = llvm.xor %1, %0 : i8
  %3 = llvm.or %2, %arg2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem or_not_xor_common_op_commute5_proof : or_not_xor_common_op_commute5_before ⊑ or_not_xor_common_op_commute5_after := by
  unfold or_not_xor_common_op_commute5_before or_not_xor_common_op_commute5_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_not_xor_common_op_commute5
  apply or_not_xor_common_op_commute5_thm
  ---END or_not_xor_common_op_commute5



def or_not_xor_common_op_commute6_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %2 = llvm.sub %0, %arg2 : i8
  %3 = llvm.xor %arg0, %1 : i8
  %4 = llvm.xor %arg1, %arg0 : i8
  %5 = llvm.or %2, %3 : i8
  %6 = llvm.or %4, %5 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def or_not_xor_common_op_commute6_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %2 = llvm.sub %0, %arg2 : i8
  %3 = llvm.and %arg1, %arg0 : i8
  %4 = llvm.xor %3, %1 : i8
  %5 = llvm.or %4, %2 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
theorem or_not_xor_common_op_commute6_proof : or_not_xor_common_op_commute6_before ⊑ or_not_xor_common_op_commute6_after := by
  unfold or_not_xor_common_op_commute6_before or_not_xor_common_op_commute6_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_not_xor_common_op_commute6
  apply or_not_xor_common_op_commute6_thm
  ---END or_not_xor_common_op_commute6



def or_not_xor_common_op_commute7_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %2 = llvm.sub %0, %arg2 : i8
  %3 = llvm.xor %arg0, %1 : i8
  %4 = llvm.xor %arg1, %arg0 : i8
  %5 = llvm.or %2, %3 : i8
  %6 = llvm.or %5, %4 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def or_not_xor_common_op_commute7_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %2 = llvm.sub %0, %arg2 : i8
  %3 = llvm.and %arg1, %arg0 : i8
  %4 = llvm.xor %3, %1 : i8
  %5 = llvm.or %4, %2 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
theorem or_not_xor_common_op_commute7_proof : or_not_xor_common_op_commute7_before ⊑ or_not_xor_common_op_commute7_after := by
  unfold or_not_xor_common_op_commute7_before or_not_xor_common_op_commute7_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_not_xor_common_op_commute7
  apply or_not_xor_common_op_commute7_thm
  ---END or_not_xor_common_op_commute7



def or_nand_xor_common_op_commute0_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = "llvm.mlir.constant"() <{value = -1 : i4}> : () -> i4
  %1 = llvm.and %arg0, %arg2 : i4
  %2 = llvm.xor %1, %0 : i4
  %3 = llvm.xor %arg0, %arg1 : i4
  %4 = llvm.or %2, %3 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def or_nand_xor_common_op_commute0_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = "llvm.mlir.constant"() <{value = -1 : i4}> : () -> i4
  %1 = llvm.and %arg0, %arg2 : i4
  %2 = llvm.and %1, %arg1 : i4
  %3 = llvm.xor %2, %0 : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
theorem or_nand_xor_common_op_commute0_proof : or_nand_xor_common_op_commute0_before ⊑ or_nand_xor_common_op_commute0_after := by
  unfold or_nand_xor_common_op_commute0_before or_nand_xor_common_op_commute0_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_nand_xor_common_op_commute0
  apply or_nand_xor_common_op_commute0_thm
  ---END or_nand_xor_common_op_commute0



def PR75692_1_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -5 : i32}> : () -> i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.xor %arg0, %1 : i32
  %4 = llvm.or %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def PR75692_1_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem PR75692_1_proof : PR75692_1_before ⊑ PR75692_1_after := by
  unfold PR75692_1_before PR75692_1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN PR75692_1
  apply PR75692_1_thm
  ---END PR75692_1



def or_xor_not_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %0 : i32
  %2 = llvm.xor %arg0, %1 : i32
  %3 = llvm.or %2, %arg1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def or_xor_not_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.or %1, %arg1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem or_xor_not_proof : or_xor_not_before ⊑ or_xor_not_after := by
  unfold or_xor_not_before or_xor_not_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_xor_not
  all_goals (try extract_goal ; sorry)
  ---END or_xor_not



def or_xor_and_commuted1_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.mul %arg1, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.xor %2, %arg0 : i32
  %4 = llvm.or %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def or_xor_and_commuted1_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.mul %arg1, %arg1 : i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.or %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem or_xor_and_commuted1_proof : or_xor_and_commuted1_before ⊑ or_xor_and_commuted1_after := by
  unfold or_xor_and_commuted1_before or_xor_and_commuted1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_xor_and_commuted1
  all_goals (try extract_goal ; sorry)
  ---END or_xor_and_commuted1



def or_xor_and_commuted2_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.mul %arg1, %arg1 : i32
  %2 = llvm.mul %arg0, %arg0 : i32
  %3 = llvm.xor %1, %0 : i32
  %4 = llvm.xor %2, %3 : i32
  %5 = llvm.or %4, %1 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def or_xor_and_commuted2_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.mul %arg1, %arg1 : i32
  %2 = llvm.mul %arg0, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.or %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem or_xor_and_commuted2_proof : or_xor_and_commuted2_before ⊑ or_xor_and_commuted2_after := by
  unfold or_xor_and_commuted2_before or_xor_and_commuted2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_xor_and_commuted2
  all_goals (try extract_goal ; sorry)
  ---END or_xor_and_commuted2



def or_xor_tree_0000_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = llvm.mul %arg0, %0 : i32
  %2 = llvm.mul %arg1, %0 : i32
  %3 = llvm.mul %arg2, %0 : i32
  %4 = llvm.xor %1, %2 : i32
  %5 = llvm.xor %2, %3 : i32
  %6 = llvm.xor %5, %1 : i32
  %7 = llvm.or %4, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def or_xor_tree_0000_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = llvm.mul %arg0, %0 : i32
  %2 = llvm.mul %arg1, %0 : i32
  %3 = llvm.mul %arg2, %0 : i32
  %4 = llvm.xor %1, %2 : i32
  %5 = llvm.or %4, %3 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
theorem or_xor_tree_0000_proof : or_xor_tree_0000_before ⊑ or_xor_tree_0000_after := by
  unfold or_xor_tree_0000_before or_xor_tree_0000_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_xor_tree_0000
  all_goals (try extract_goal ; sorry)
  ---END or_xor_tree_0000



def or_xor_tree_1000_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = llvm.mul %arg0, %0 : i32
  %2 = llvm.mul %arg1, %0 : i32
  %3 = llvm.mul %arg2, %0 : i32
  %4 = llvm.xor %1, %2 : i32
  %5 = llvm.xor %2, %3 : i32
  %6 = llvm.xor %5, %1 : i32
  %7 = llvm.or %6, %4 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def or_xor_tree_1000_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = llvm.mul %arg0, %0 : i32
  %2 = llvm.mul %arg1, %0 : i32
  %3 = llvm.mul %arg2, %0 : i32
  %4 = llvm.xor %1, %2 : i32
  %5 = llvm.or %4, %3 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
theorem or_xor_tree_1000_proof : or_xor_tree_1000_before ⊑ or_xor_tree_1000_after := by
  unfold or_xor_tree_1000_before or_xor_tree_1000_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_xor_tree_1000
  all_goals (try extract_goal ; sorry)
  ---END or_xor_tree_1000


