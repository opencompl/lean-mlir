import SSA.Projects.InstCombine.tests.LLVM.gxor2_proof
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
                                                                       
def test2_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 145 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = 153 : i32}> : () -> i32
  %3 = llvm.and %arg0, %0 : i32
  %4 = llvm.add %3, %1 : i32
  %5 = llvm.xor %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = llvm.or %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
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
  apply test2_thm
  ---END test2



def test3_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 145 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 177 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = 153 : i32}> : () -> i32
  %3 = llvm.or %arg0, %0 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.xor %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test3_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = llvm.or %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
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
  apply test3_thm
  ---END test3



def test5_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1234 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %3 = llvm.xor %arg0, %0 : i32
  %4 = llvm.lshr %3, %1 : i32
  %5 = llvm.xor %4, %2 : i32
  %6 = llvm.add %5, %3 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def test5_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1234 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
  %3 = llvm.xor %arg0, %0 : i32
  %4 = llvm.lshr %arg0, %1 : i32
  %5 = llvm.xor %4, %2 : i32
  %6 = llvm.add %5, %3 : i32
  "llvm.return"(%6) : (i32) -> ()
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
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1234 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.lshr %2, %1 : i32
  %4 = llvm.add %3, %2 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test6_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1234 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.lshr %arg0, %1 : i32
  %4 = llvm.add %3, %2 : i32
  "llvm.return"(%4) : (i32) -> ()
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
  apply test6_thm
  ---END test6



def test7_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.or %arg0, %arg1 : i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.xor %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test7_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %0 : i32
  %2 = llvm.or %1, %arg0 : i32
  "llvm.return"(%2) : (i32) -> ()
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



def test8_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.or %arg0, %arg1 : i32
  %3 = llvm.xor %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test8_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %0 : i32
  %2 = llvm.or %1, %arg0 : i32
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
  apply test8_thm
  ---END test8



def test9_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.and %arg0, %arg1 : i32
  %1 = llvm.xor %arg0, %arg1 : i32
  %2 = llvm.xor %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test9_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.or %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
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



def test9b_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.and %arg0, %arg1 : i32
  %1 = llvm.xor %arg1, %arg0 : i32
  %2 = llvm.xor %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test9b_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.or %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test9b_proof : test9b_before ⊑ test9b_after := by
  unfold test9b_before test9b_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test9b
  all_goals (try extract_goal ; sorry)
  ---END test9b



def test10_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.xor %arg0, %arg1 : i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = llvm.xor %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test10_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.or %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
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



def test10b_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.xor %arg0, %arg1 : i32
  %1 = llvm.and %arg1, %arg0 : i32
  %2 = llvm.xor %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test10b_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.or %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test10b_proof : test10b_before ⊑ test10b_after := by
  unfold test10b_before test10b_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test10b
  all_goals (try extract_goal ; sorry)
  ---END test10b



def test11_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %arg0 : i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.xor %2, %arg1 : i32
  %4 = llvm.and %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test11_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %arg0 : i32
  %2 = llvm.xor %arg0, %arg1 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.and %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
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
  all_goals (try extract_goal ; sorry)
  ---END test11



def test11b_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %arg0 : i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.xor %2, %arg1 : i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test11b_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %arg0 : i32
  %2 = llvm.xor %arg0, %arg1 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.and %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem test11b_proof : test11b_before ⊑ test11b_after := by
  unfold test11b_before test11b_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test11b
  all_goals (try extract_goal ; sorry)
  ---END test11b



def test11c_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %arg1 : i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.xor %2, %arg1 : i32
  %4 = llvm.and %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test11c_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %arg1 : i32
  %2 = llvm.xor %arg0, %arg1 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.and %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem test11c_proof : test11c_before ⊑ test11c_after := by
  unfold test11c_before test11c_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test11c
  all_goals (try extract_goal ; sorry)
  ---END test11c



def test11d_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %arg1 : i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.xor %2, %arg1 : i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test11d_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %arg1 : i32
  %2 = llvm.xor %arg0, %arg1 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.and %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem test11d_proof : test11d_before ⊑ test11d_after := by
  unfold test11d_before test11d_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test11d
  all_goals (try extract_goal ; sorry)
  ---END test11d



def test11e_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.mul %arg1, %arg2 : i32
  %2 = llvm.xor %1, %arg0 : i32
  %3 = llvm.xor %arg0, %0 : i32
  %4 = llvm.xor %1, %3 : i32
  %5 = llvm.and %2, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test11e_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.mul %arg1, %arg2 : i32
  %2 = llvm.xor %1, %arg0 : i32
  %3 = llvm.xor %1, %arg0 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.and %2, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
theorem test11e_proof : test11e_before ⊑ test11e_after := by
  unfold test11e_before test11e_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test11e
  all_goals (try extract_goal ; sorry)
  ---END test11e



def test11f_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.mul %arg1, %arg2 : i32
  %2 = llvm.xor %1, %arg0 : i32
  %3 = llvm.xor %arg0, %0 : i32
  %4 = llvm.xor %1, %3 : i32
  %5 = llvm.and %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test11f_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.mul %arg1, %arg2 : i32
  %2 = llvm.xor %1, %arg0 : i32
  %3 = llvm.xor %1, %arg0 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.and %2, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
theorem test11f_proof : test11f_before ⊑ test11f_after := by
  unfold test11f_before test11f_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test11f
  all_goals (try extract_goal ; sorry)
  ---END test11f



def test12_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %0 : i32
  %2 = llvm.and %arg0, %1 : i32
  %3 = llvm.xor %arg0, %0 : i32
  %4 = llvm.xor %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test12_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
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



def test12commuted_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %0 : i32
  %2 = llvm.and %1, %arg0 : i32
  %3 = llvm.xor %arg0, %0 : i32
  %4 = llvm.xor %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test12commuted_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem test12commuted_proof : test12commuted_before ⊑ test12commuted_after := by
  unfold test12commuted_before test12commuted_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test12commuted
  apply test12commuted_thm
  ---END test12commuted



def test13_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.xor %arg1, %0 : i32
  %3 = llvm.and %arg0, %2 : i32
  %4 = llvm.xor %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test13_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
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
  apply test13_thm
  ---END test13



def test13commuted_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.xor %arg1, %0 : i32
  %3 = llvm.and %2, %arg0 : i32
  %4 = llvm.xor %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test13commuted_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem test13commuted_proof : test13commuted_before ⊑ test13commuted_after := by
  unfold test13commuted_before test13commuted_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test13commuted
  apply test13commuted_thm
  ---END test13commuted



def xor_or_xor_common_op_commute1_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = llvm.xor %arg0, %arg2 : i32
  %1 = llvm.or %arg0, %arg1 : i32
  %2 = llvm.xor %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def xor_or_xor_common_op_commute1_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.and %1, %arg1 : i32
  %3 = llvm.xor %2, %arg2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem xor_or_xor_common_op_commute1_proof : xor_or_xor_common_op_commute1_before ⊑ xor_or_xor_common_op_commute1_after := by
  unfold xor_or_xor_common_op_commute1_before xor_or_xor_common_op_commute1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN xor_or_xor_common_op_commute1
  apply xor_or_xor_common_op_commute1_thm
  ---END xor_or_xor_common_op_commute1



def xor_or_xor_common_op_commute2_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = llvm.xor %arg2, %arg0 : i32
  %1 = llvm.or %arg0, %arg1 : i32
  %2 = llvm.xor %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def xor_or_xor_common_op_commute2_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.and %1, %arg1 : i32
  %3 = llvm.xor %2, %arg2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem xor_or_xor_common_op_commute2_proof : xor_or_xor_common_op_commute2_before ⊑ xor_or_xor_common_op_commute2_after := by
  unfold xor_or_xor_common_op_commute2_before xor_or_xor_common_op_commute2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN xor_or_xor_common_op_commute2
  apply xor_or_xor_common_op_commute2_thm
  ---END xor_or_xor_common_op_commute2



def xor_or_xor_common_op_commute3_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = llvm.xor %arg0, %arg2 : i32
  %1 = llvm.or %arg1, %arg0 : i32
  %2 = llvm.xor %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def xor_or_xor_common_op_commute3_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.and %1, %arg1 : i32
  %3 = llvm.xor %2, %arg2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem xor_or_xor_common_op_commute3_proof : xor_or_xor_common_op_commute3_before ⊑ xor_or_xor_common_op_commute3_after := by
  unfold xor_or_xor_common_op_commute3_before xor_or_xor_common_op_commute3_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN xor_or_xor_common_op_commute3
  apply xor_or_xor_common_op_commute3_thm
  ---END xor_or_xor_common_op_commute3



def xor_or_xor_common_op_commute4_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = llvm.xor %arg2, %arg0 : i32
  %1 = llvm.or %arg1, %arg0 : i32
  %2 = llvm.xor %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def xor_or_xor_common_op_commute4_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.and %1, %arg1 : i32
  %3 = llvm.xor %2, %arg2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem xor_or_xor_common_op_commute4_proof : xor_or_xor_common_op_commute4_before ⊑ xor_or_xor_common_op_commute4_after := by
  unfold xor_or_xor_common_op_commute4_before xor_or_xor_common_op_commute4_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN xor_or_xor_common_op_commute4
  apply xor_or_xor_common_op_commute4_thm
  ---END xor_or_xor_common_op_commute4



def xor_or_xor_common_op_commute5_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = llvm.xor %arg0, %arg2 : i32
  %1 = llvm.or %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def xor_or_xor_common_op_commute5_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.and %1, %arg1 : i32
  %3 = llvm.xor %2, %arg2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem xor_or_xor_common_op_commute5_proof : xor_or_xor_common_op_commute5_before ⊑ xor_or_xor_common_op_commute5_after := by
  unfold xor_or_xor_common_op_commute5_before xor_or_xor_common_op_commute5_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN xor_or_xor_common_op_commute5
  apply xor_or_xor_common_op_commute5_thm
  ---END xor_or_xor_common_op_commute5



def xor_or_xor_common_op_commute6_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = llvm.xor %arg2, %arg0 : i32
  %1 = llvm.or %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def xor_or_xor_common_op_commute6_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.and %1, %arg1 : i32
  %3 = llvm.xor %2, %arg2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem xor_or_xor_common_op_commute6_proof : xor_or_xor_common_op_commute6_before ⊑ xor_or_xor_common_op_commute6_after := by
  unfold xor_or_xor_common_op_commute6_before xor_or_xor_common_op_commute6_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN xor_or_xor_common_op_commute6
  apply xor_or_xor_common_op_commute6_thm
  ---END xor_or_xor_common_op_commute6



def xor_or_xor_common_op_commute7_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = llvm.xor %arg0, %arg2 : i32
  %1 = llvm.or %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def xor_or_xor_common_op_commute7_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.and %1, %arg1 : i32
  %3 = llvm.xor %2, %arg2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem xor_or_xor_common_op_commute7_proof : xor_or_xor_common_op_commute7_before ⊑ xor_or_xor_common_op_commute7_after := by
  unfold xor_or_xor_common_op_commute7_before xor_or_xor_common_op_commute7_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN xor_or_xor_common_op_commute7
  apply xor_or_xor_common_op_commute7_thm
  ---END xor_or_xor_common_op_commute7



def xor_or_xor_common_op_commute8_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = llvm.xor %arg2, %arg0 : i32
  %1 = llvm.or %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def xor_or_xor_common_op_commute8_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.and %1, %arg1 : i32
  %3 = llvm.xor %2, %arg2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem xor_or_xor_common_op_commute8_proof : xor_or_xor_common_op_commute8_before ⊑ xor_or_xor_common_op_commute8_after := by
  unfold xor_or_xor_common_op_commute8_before xor_or_xor_common_op_commute8_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN xor_or_xor_common_op_commute8
  apply xor_or_xor_common_op_commute8_thm
  ---END xor_or_xor_common_op_commute8



def test15_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 33 : i8}> : () -> i8
  %1 = llvm.xor %arg1, %arg0 : i8
  %2 = llvm.xor %arg0, %0 : i8
  %3 = llvm.xor %2, %arg1 : i8
  %4 = llvm.and %1, %3 : i8
  %5 = llvm.mul %4, %3 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def test15_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 33 : i8}> : () -> i8
  %1 = llvm.xor %arg1, %arg0 : i8
  %2 = llvm.xor %arg0, %arg1 : i8
  %3 = llvm.xor %2, %0 : i8
  %4 = llvm.and %1, %3 : i8
  %5 = llvm.mul %4, %3 : i8
  "llvm.return"(%5) : (i8) -> ()
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



def test16_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 33 : i8}> : () -> i8
  %1 = llvm.xor %arg1, %arg0 : i8
  %2 = llvm.xor %arg0, %0 : i8
  %3 = llvm.xor %2, %arg1 : i8
  %4 = llvm.and %3, %1 : i8
  %5 = llvm.mul %4, %3 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def test16_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 33 : i8}> : () -> i8
  %1 = llvm.xor %arg1, %arg0 : i8
  %2 = llvm.xor %arg0, %arg1 : i8
  %3 = llvm.xor %2, %0 : i8
  %4 = llvm.and %3, %1 : i8
  %5 = llvm.mul %4, %3 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
theorem test16_proof : test16_before ⊑ test16_after := by
  unfold test16_before test16_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test16
  apply test16_thm
  ---END test16



def not_xor_to_or_not1_before := [llvm|
{
^0(%arg0 : i3, %arg1 : i3, %arg2 : i3):
  %0 = "llvm.mlir.constant"() <{value = -1 : i3}> : () -> i3
  %1 = llvm.or %arg1, %arg2 : i3
  %2 = llvm.and %arg0, %arg2 : i3
  %3 = llvm.xor %2, %1 : i3
  %4 = llvm.xor %3, %0 : i3
  "llvm.return"(%4) : (i3) -> ()
}
]
def not_xor_to_or_not1_after := [llvm|
{
^0(%arg0 : i3, %arg1 : i3, %arg2 : i3):
  %0 = "llvm.mlir.constant"() <{value = -1 : i3}> : () -> i3
  %1 = llvm.or %arg1, %arg2 : i3
  %2 = llvm.and %arg0, %arg2 : i3
  %3 = llvm.xor %1, %0 : i3
  %4 = llvm.or %2, %3 : i3
  "llvm.return"(%4) : (i3) -> ()
}
]
theorem not_xor_to_or_not1_proof : not_xor_to_or_not1_before ⊑ not_xor_to_or_not1_after := by
  unfold not_xor_to_or_not1_before not_xor_to_or_not1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN not_xor_to_or_not1
  apply not_xor_to_or_not1_thm
  ---END not_xor_to_or_not1



def not_xor_to_or_not2_before := [llvm|
{
^0(%arg0 : i3, %arg1 : i3, %arg2 : i3):
  %0 = "llvm.mlir.constant"() <{value = -1 : i3}> : () -> i3
  %1 = llvm.or %arg2, %arg1 : i3
  %2 = llvm.and %arg0, %arg2 : i3
  %3 = llvm.xor %2, %1 : i3
  %4 = llvm.xor %3, %0 : i3
  "llvm.return"(%4) : (i3) -> ()
}
]
def not_xor_to_or_not2_after := [llvm|
{
^0(%arg0 : i3, %arg1 : i3, %arg2 : i3):
  %0 = "llvm.mlir.constant"() <{value = -1 : i3}> : () -> i3
  %1 = llvm.or %arg2, %arg1 : i3
  %2 = llvm.and %arg0, %arg2 : i3
  %3 = llvm.xor %1, %0 : i3
  %4 = llvm.or %2, %3 : i3
  "llvm.return"(%4) : (i3) -> ()
}
]
theorem not_xor_to_or_not2_proof : not_xor_to_or_not2_before ⊑ not_xor_to_or_not2_after := by
  unfold not_xor_to_or_not2_before not_xor_to_or_not2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN not_xor_to_or_not2
  apply not_xor_to_or_not2_thm
  ---END not_xor_to_or_not2



def not_xor_to_or_not3_before := [llvm|
{
^0(%arg0 : i3, %arg1 : i3, %arg2 : i3):
  %0 = "llvm.mlir.constant"() <{value = -1 : i3}> : () -> i3
  %1 = llvm.or %arg2, %arg1 : i3
  %2 = llvm.and %arg2, %arg0 : i3
  %3 = llvm.xor %2, %1 : i3
  %4 = llvm.xor %3, %0 : i3
  "llvm.return"(%4) : (i3) -> ()
}
]
def not_xor_to_or_not3_after := [llvm|
{
^0(%arg0 : i3, %arg1 : i3, %arg2 : i3):
  %0 = "llvm.mlir.constant"() <{value = -1 : i3}> : () -> i3
  %1 = llvm.or %arg2, %arg1 : i3
  %2 = llvm.and %arg2, %arg0 : i3
  %3 = llvm.xor %1, %0 : i3
  %4 = llvm.or %2, %3 : i3
  "llvm.return"(%4) : (i3) -> ()
}
]
theorem not_xor_to_or_not3_proof : not_xor_to_or_not3_before ⊑ not_xor_to_or_not3_after := by
  unfold not_xor_to_or_not3_before not_xor_to_or_not3_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN not_xor_to_or_not3
  apply not_xor_to_or_not3_thm
  ---END not_xor_to_or_not3



def not_xor_to_or_not4_before := [llvm|
{
^0(%arg0 : i3, %arg1 : i3, %arg2 : i3):
  %0 = "llvm.mlir.constant"() <{value = -1 : i3}> : () -> i3
  %1 = llvm.or %arg1, %arg2 : i3
  %2 = llvm.and %arg2, %arg0 : i3
  %3 = llvm.xor %2, %1 : i3
  %4 = llvm.xor %3, %0 : i3
  "llvm.return"(%4) : (i3) -> ()
}
]
def not_xor_to_or_not4_after := [llvm|
{
^0(%arg0 : i3, %arg1 : i3, %arg2 : i3):
  %0 = "llvm.mlir.constant"() <{value = -1 : i3}> : () -> i3
  %1 = llvm.or %arg1, %arg2 : i3
  %2 = llvm.and %arg2, %arg0 : i3
  %3 = llvm.xor %1, %0 : i3
  %4 = llvm.or %2, %3 : i3
  "llvm.return"(%4) : (i3) -> ()
}
]
theorem not_xor_to_or_not4_proof : not_xor_to_or_not4_before ⊑ not_xor_to_or_not4_after := by
  unfold not_xor_to_or_not4_before not_xor_to_or_not4_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN not_xor_to_or_not4
  apply not_xor_to_or_not4_thm
  ---END not_xor_to_or_not4



def xor_notand_to_or_not1_before := [llvm|
{
^0(%arg0 : i3, %arg1 : i3, %arg2 : i3):
  %0 = "llvm.mlir.constant"() <{value = -1 : i3}> : () -> i3
  %1 = llvm.or %arg1, %arg2 : i3
  %2 = llvm.and %arg0, %arg2 : i3
  %3 = llvm.xor %2, %0 : i3
  %4 = llvm.xor %3, %1 : i3
  "llvm.return"(%4) : (i3) -> ()
}
]
def xor_notand_to_or_not1_after := [llvm|
{
^0(%arg0 : i3, %arg1 : i3, %arg2 : i3):
  %0 = "llvm.mlir.constant"() <{value = -1 : i3}> : () -> i3
  %1 = llvm.or %arg1, %arg2 : i3
  %2 = llvm.and %arg0, %arg2 : i3
  %3 = llvm.xor %1, %0 : i3
  %4 = llvm.or %2, %3 : i3
  "llvm.return"(%4) : (i3) -> ()
}
]
theorem xor_notand_to_or_not1_proof : xor_notand_to_or_not1_before ⊑ xor_notand_to_or_not1_after := by
  unfold xor_notand_to_or_not1_before xor_notand_to_or_not1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN xor_notand_to_or_not1
  apply xor_notand_to_or_not1_thm
  ---END xor_notand_to_or_not1



def xor_notand_to_or_not2_before := [llvm|
{
^0(%arg0 : i3, %arg1 : i3, %arg2 : i3):
  %0 = "llvm.mlir.constant"() <{value = -1 : i3}> : () -> i3
  %1 = llvm.or %arg2, %arg1 : i3
  %2 = llvm.and %arg0, %arg2 : i3
  %3 = llvm.xor %2, %0 : i3
  %4 = llvm.xor %3, %1 : i3
  "llvm.return"(%4) : (i3) -> ()
}
]
def xor_notand_to_or_not2_after := [llvm|
{
^0(%arg0 : i3, %arg1 : i3, %arg2 : i3):
  %0 = "llvm.mlir.constant"() <{value = -1 : i3}> : () -> i3
  %1 = llvm.or %arg2, %arg1 : i3
  %2 = llvm.and %arg0, %arg2 : i3
  %3 = llvm.xor %1, %0 : i3
  %4 = llvm.or %2, %3 : i3
  "llvm.return"(%4) : (i3) -> ()
}
]
theorem xor_notand_to_or_not2_proof : xor_notand_to_or_not2_before ⊑ xor_notand_to_or_not2_after := by
  unfold xor_notand_to_or_not2_before xor_notand_to_or_not2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN xor_notand_to_or_not2
  apply xor_notand_to_or_not2_thm
  ---END xor_notand_to_or_not2



def xor_notand_to_or_not3_before := [llvm|
{
^0(%arg0 : i3, %arg1 : i3, %arg2 : i3):
  %0 = "llvm.mlir.constant"() <{value = -1 : i3}> : () -> i3
  %1 = llvm.or %arg2, %arg1 : i3
  %2 = llvm.and %arg2, %arg0 : i3
  %3 = llvm.xor %2, %0 : i3
  %4 = llvm.xor %3, %1 : i3
  "llvm.return"(%4) : (i3) -> ()
}
]
def xor_notand_to_or_not3_after := [llvm|
{
^0(%arg0 : i3, %arg1 : i3, %arg2 : i3):
  %0 = "llvm.mlir.constant"() <{value = -1 : i3}> : () -> i3
  %1 = llvm.or %arg2, %arg1 : i3
  %2 = llvm.and %arg2, %arg0 : i3
  %3 = llvm.xor %1, %0 : i3
  %4 = llvm.or %2, %3 : i3
  "llvm.return"(%4) : (i3) -> ()
}
]
theorem xor_notand_to_or_not3_proof : xor_notand_to_or_not3_before ⊑ xor_notand_to_or_not3_after := by
  unfold xor_notand_to_or_not3_before xor_notand_to_or_not3_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN xor_notand_to_or_not3
  apply xor_notand_to_or_not3_thm
  ---END xor_notand_to_or_not3



def xor_notand_to_or_not4_before := [llvm|
{
^0(%arg0 : i3, %arg1 : i3, %arg2 : i3):
  %0 = "llvm.mlir.constant"() <{value = -1 : i3}> : () -> i3
  %1 = llvm.or %arg1, %arg2 : i3
  %2 = llvm.and %arg2, %arg0 : i3
  %3 = llvm.xor %2, %0 : i3
  %4 = llvm.xor %3, %1 : i3
  "llvm.return"(%4) : (i3) -> ()
}
]
def xor_notand_to_or_not4_after := [llvm|
{
^0(%arg0 : i3, %arg1 : i3, %arg2 : i3):
  %0 = "llvm.mlir.constant"() <{value = -1 : i3}> : () -> i3
  %1 = llvm.or %arg1, %arg2 : i3
  %2 = llvm.and %arg2, %arg0 : i3
  %3 = llvm.xor %1, %0 : i3
  %4 = llvm.or %2, %3 : i3
  "llvm.return"(%4) : (i3) -> ()
}
]
theorem xor_notand_to_or_not4_proof : xor_notand_to_or_not4_before ⊑ xor_notand_to_or_not4_after := by
  unfold xor_notand_to_or_not4_before xor_notand_to_or_not4_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN xor_notand_to_or_not4
  apply xor_notand_to_or_not4_thm
  ---END xor_notand_to_or_not4


