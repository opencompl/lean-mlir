import SSA.Projects.InstCombine.tests.LLVM.gapinthshift_proof
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
                                                                       
def test6_before := [llvm|
{
^0(%arg0 : i55):
  %0 = "llvm.mlir.constant"() <{value = 1 : i55}> : () -> i55
  %1 = "llvm.mlir.constant"() <{value = 3 : i55}> : () -> i55
  %2 = llvm.shl %arg0, %0 : i55
  %3 = llvm.mul %2, %1 : i55
  "llvm.return"(%3) : (i55) -> ()
}
]
def test6_after := [llvm|
{
^0(%arg0 : i55):
  %0 = "llvm.mlir.constant"() <{value = 6 : i55}> : () -> i55
  %1 = llvm.mul %arg0, %0 : i55
  "llvm.return"(%1) : (i55) -> ()
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



def test6a_before := [llvm|
{
^0(%arg0 : i55):
  %0 = "llvm.mlir.constant"() <{value = 3 : i55}> : () -> i55
  %1 = "llvm.mlir.constant"() <{value = 1 : i55}> : () -> i55
  %2 = llvm.mul %arg0, %0 : i55
  %3 = llvm.shl %2, %1 : i55
  "llvm.return"(%3) : (i55) -> ()
}
]
def test6a_after := [llvm|
{
^0(%arg0 : i55):
  %0 = "llvm.mlir.constant"() <{value = 6 : i55}> : () -> i55
  %1 = llvm.mul %arg0, %0 : i55
  "llvm.return"(%1) : (i55) -> ()
}
]
theorem test6a_proof : test6a_before ⊑ test6a_after := by
  unfold test6a_before test6a_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test6a
  apply test6a_thm
  ---END test6a



def test8_before := [llvm|
{
^0(%arg0 : i7):
  %0 = "llvm.mlir.constant"() <{value = 4 : i7}> : () -> i7
  %1 = "llvm.mlir.constant"() <{value = 3 : i7}> : () -> i7
  %2 = llvm.shl %arg0, %0 : i7
  %3 = llvm.shl %2, %1 : i7
  "llvm.return"(%3) : (i7) -> ()
}
]
def test8_after := [llvm|
{
^0(%arg0 : i7):
  %0 = "llvm.mlir.constant"() <{value = 0 : i7}> : () -> i7
  "llvm.return"(%0) : (i7) -> ()
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
^0(%arg0 : i17):
  %0 = "llvm.mlir.constant"() <{value = 16 : i17}> : () -> i17
  %1 = llvm.shl %arg0, %0 : i17
  %2 = llvm.lshr %1, %0 : i17
  "llvm.return"(%2) : (i17) -> ()
}
]
def test9_after := [llvm|
{
^0(%arg0 : i17):
  %0 = "llvm.mlir.constant"() <{value = 1 : i17}> : () -> i17
  %1 = llvm.and %arg0, %0 : i17
  "llvm.return"(%1) : (i17) -> ()
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
  apply test9_thm
  ---END test9



def test10_before := [llvm|
{
^0(%arg0 : i19):
  %0 = "llvm.mlir.constant"() <{value = 18 : i19}> : () -> i19
  %1 = llvm.lshr %arg0, %0 : i19
  %2 = llvm.shl %1, %0 : i19
  "llvm.return"(%2) : (i19) -> ()
}
]
def test10_after := [llvm|
{
^0(%arg0 : i19):
  %0 = "llvm.mlir.constant"() <{value = -262144 : i19}> : () -> i19
  %1 = llvm.and %arg0, %0 : i19
  "llvm.return"(%1) : (i19) -> ()
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



def multiuse_lshr_lshr_before := [llvm|
{
^0(%arg0 : i9):
  %0 = "llvm.mlir.constant"() <{value = 2 : i9}> : () -> i9
  %1 = "llvm.mlir.constant"() <{value = 3 : i9}> : () -> i9
  %2 = llvm.lshr %arg0, %0 : i9
  %3 = llvm.lshr %2, %1 : i9
  %4 = llvm.mul %2, %3 : i9
  "llvm.return"(%4) : (i9) -> ()
}
]
def multiuse_lshr_lshr_after := [llvm|
{
^0(%arg0 : i9):
  %0 = "llvm.mlir.constant"() <{value = 2 : i9}> : () -> i9
  %1 = "llvm.mlir.constant"() <{value = 5 : i9}> : () -> i9
  %2 = llvm.lshr %arg0, %0 : i9
  %3 = llvm.lshr %arg0, %1 : i9
  %4 = llvm.mul %2, %3 : i9
  "llvm.return"(%4) : (i9) -> ()
}
]
theorem multiuse_lshr_lshr_proof : multiuse_lshr_lshr_before ⊑ multiuse_lshr_lshr_after := by
  unfold multiuse_lshr_lshr_before multiuse_lshr_lshr_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN multiuse_lshr_lshr
  all_goals (try extract_goal ; sorry)
  ---END multiuse_lshr_lshr



def multiuse_shl_shl_before := [llvm|
{
^0(%arg0 : i42):
  %0 = "llvm.mlir.constant"() <{value = 8 : i42}> : () -> i42
  %1 = "llvm.mlir.constant"() <{value = 9 : i42}> : () -> i42
  %2 = llvm.shl %arg0, %0 : i42
  %3 = llvm.shl %2, %1 : i42
  %4 = llvm.mul %2, %3 : i42
  "llvm.return"(%4) : (i42) -> ()
}
]
def multiuse_shl_shl_after := [llvm|
{
^0(%arg0 : i42):
  %0 = "llvm.mlir.constant"() <{value = 8 : i42}> : () -> i42
  %1 = "llvm.mlir.constant"() <{value = 17 : i42}> : () -> i42
  %2 = llvm.shl %arg0, %0 : i42
  %3 = llvm.shl %arg0, %1 : i42
  %4 = llvm.mul %2, %3 : i42
  "llvm.return"(%4) : (i42) -> ()
}
]
theorem multiuse_shl_shl_proof : multiuse_shl_shl_before ⊑ multiuse_shl_shl_after := by
  unfold multiuse_shl_shl_before multiuse_shl_shl_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN multiuse_shl_shl
  all_goals (try extract_goal ; sorry)
  ---END multiuse_shl_shl



def test11_before := [llvm|
{
^0(%arg0 : i23):
  %0 = "llvm.mlir.constant"() <{value = 3 : i23}> : () -> i23
  %1 = "llvm.mlir.constant"() <{value = 11 : i23}> : () -> i23
  %2 = "llvm.mlir.constant"() <{value = 12 : i23}> : () -> i23
  %3 = llvm.mul %arg0, %0 : i23
  %4 = llvm.lshr %3, %1 : i23
  %5 = llvm.shl %4, %2 : i23
  "llvm.return"(%5) : (i23) -> ()
}
]
def test11_after := [llvm|
{
^0(%arg0 : i23):
  %0 = "llvm.mlir.constant"() <{value = 6 : i23}> : () -> i23
  %1 = "llvm.mlir.constant"() <{value = -4096 : i23}> : () -> i23
  %2 = llvm.mul %arg0, %0 : i23
  %3 = llvm.and %2, %1 : i23
  "llvm.return"(%3) : (i23) -> ()
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



def test12_before := [llvm|
{
^0(%arg0 : i47):
  %0 = "llvm.mlir.constant"() <{value = 8 : i47}> : () -> i47
  %1 = llvm.ashr %arg0, %0 : i47
  %2 = llvm.shl %1, %0 : i47
  "llvm.return"(%2) : (i47) -> ()
}
]
def test12_after := [llvm|
{
^0(%arg0 : i47):
  %0 = "llvm.mlir.constant"() <{value = -256 : i47}> : () -> i47
  %1 = llvm.and %arg0, %0 : i47
  "llvm.return"(%1) : (i47) -> ()
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
  all_goals (try extract_goal ; sorry)
  ---END test12



def test13_before := [llvm|
{
^0(%arg0 : i18):
  %0 = "llvm.mlir.constant"() <{value = 3 : i18}> : () -> i18
  %1 = "llvm.mlir.constant"() <{value = 8 : i18}> : () -> i18
  %2 = "llvm.mlir.constant"() <{value = 9 : i18}> : () -> i18
  %3 = llvm.mul %arg0, %0 : i18
  %4 = llvm.ashr %3, %1 : i18
  %5 = llvm.shl %4, %2 : i18
  "llvm.return"(%5) : (i18) -> ()
}
]
def test13_after := [llvm|
{
^0(%arg0 : i18):
  %0 = "llvm.mlir.constant"() <{value = 6 : i18}> : () -> i18
  %1 = "llvm.mlir.constant"() <{value = -512 : i18}> : () -> i18
  %2 = llvm.mul %arg0, %0 : i18
  %3 = llvm.and %2, %1 : i18
  "llvm.return"(%3) : (i18) -> ()
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
^0(%arg0 : i35):
  %0 = "llvm.mlir.constant"() <{value = 4 : i35}> : () -> i35
  %1 = "llvm.mlir.constant"() <{value = 1234 : i35}> : () -> i35
  %2 = llvm.lshr %arg0, %0 : i35
  %3 = llvm.or %2, %1 : i35
  %4 = llvm.shl %3, %0 : i35
  "llvm.return"(%4) : (i35) -> ()
}
]
def test14_after := [llvm|
{
^0(%arg0 : i35):
  %0 = "llvm.mlir.constant"() <{value = -19760 : i35}> : () -> i35
  %1 = "llvm.mlir.constant"() <{value = 19744 : i35}> : () -> i35
  %2 = llvm.and %arg0, %0 : i35
  %3 = llvm.or %2, %1 : i35
  "llvm.return"(%3) : (i35) -> ()
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
  all_goals (try extract_goal ; sorry)
  ---END test14



def test14a_before := [llvm|
{
^0(%arg0 : i79):
  %0 = "llvm.mlir.constant"() <{value = 4 : i79}> : () -> i79
  %1 = "llvm.mlir.constant"() <{value = 1234 : i79}> : () -> i79
  %2 = llvm.shl %arg0, %0 : i79
  %3 = llvm.and %2, %1 : i79
  %4 = llvm.lshr %3, %0 : i79
  "llvm.return"(%4) : (i79) -> ()
}
]
def test14a_after := [llvm|
{
^0(%arg0 : i79):
  %0 = "llvm.mlir.constant"() <{value = 77 : i79}> : () -> i79
  %1 = llvm.and %arg0, %0 : i79
  "llvm.return"(%1) : (i79) -> ()
}
]
theorem test14a_proof : test14a_before ⊑ test14a_after := by
  unfold test14a_before test14a_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test14a
  all_goals (try extract_goal ; sorry)
  ---END test14a



def shl_lshr_eq_amt_multi_use_before := [llvm|
{
^0(%arg0 : i44):
  %0 = "llvm.mlir.constant"() <{value = 33 : i44}> : () -> i44
  %1 = llvm.shl %arg0, %0 : i44
  %2 = llvm.lshr %1, %0 : i44
  %3 = llvm.add %1, %2 : i44
  "llvm.return"(%3) : (i44) -> ()
}
]
def shl_lshr_eq_amt_multi_use_after := [llvm|
{
^0(%arg0 : i44):
  %0 = "llvm.mlir.constant"() <{value = 33 : i44}> : () -> i44
  %1 = "llvm.mlir.constant"() <{value = 2047 : i44}> : () -> i44
  %2 = llvm.shl %arg0, %0 : i44
  %3 = llvm.and %arg0, %1 : i44
  %4 = llvm.or %2, %3 : i44
  "llvm.return"(%4) : (i44) -> ()
}
]
theorem shl_lshr_eq_amt_multi_use_proof : shl_lshr_eq_amt_multi_use_before ⊑ shl_lshr_eq_amt_multi_use_after := by
  unfold shl_lshr_eq_amt_multi_use_before shl_lshr_eq_amt_multi_use_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN shl_lshr_eq_amt_multi_use
  all_goals (try extract_goal ; sorry)
  ---END shl_lshr_eq_amt_multi_use



def lshr_shl_eq_amt_multi_use_before := [llvm|
{
^0(%arg0 : i43):
  %0 = "llvm.mlir.constant"() <{value = 23 : i43}> : () -> i43
  %1 = llvm.lshr %arg0, %0 : i43
  %2 = llvm.shl %1, %0 : i43
  %3 = llvm.mul %1, %2 : i43
  "llvm.return"(%3) : (i43) -> ()
}
]
def lshr_shl_eq_amt_multi_use_after := [llvm|
{
^0(%arg0 : i43):
  %0 = "llvm.mlir.constant"() <{value = 23 : i43}> : () -> i43
  %1 = "llvm.mlir.constant"() <{value = -8388608 : i43}> : () -> i43
  %2 = llvm.lshr %arg0, %0 : i43
  %3 = llvm.and %arg0, %1 : i43
  %4 = llvm.mul %2, %3 : i43
  "llvm.return"(%4) : (i43) -> ()
}
]
theorem lshr_shl_eq_amt_multi_use_proof : lshr_shl_eq_amt_multi_use_before ⊑ lshr_shl_eq_amt_multi_use_after := by
  unfold lshr_shl_eq_amt_multi_use_before lshr_shl_eq_amt_multi_use_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN lshr_shl_eq_amt_multi_use
  all_goals (try extract_goal ; sorry)
  ---END lshr_shl_eq_amt_multi_use



def test25_before := [llvm|
{
^0(%arg0 : i37, %arg1 : i37):
  %0 = "llvm.mlir.constant"() <{value = 17 : i37}> : () -> i37
  %1 = llvm.lshr %arg1, %0 : i37
  %2 = llvm.lshr %arg0, %0 : i37
  %3 = llvm.add %2, %1 : i37
  %4 = llvm.shl %3, %0 : i37
  "llvm.return"(%4) : (i37) -> ()
}
]
def test25_after := [llvm|
{
^0(%arg0 : i37, %arg1 : i37):
  %0 = "llvm.mlir.constant"() <{value = -131072 : i37}> : () -> i37
  %1 = llvm.and %arg0, %0 : i37
  %2 = llvm.add %1, %arg1 : i37
  %3 = llvm.and %2, %0 : i37
  "llvm.return"(%3) : (i37) -> ()
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
  all_goals (try extract_goal ; sorry)
  ---END test25


