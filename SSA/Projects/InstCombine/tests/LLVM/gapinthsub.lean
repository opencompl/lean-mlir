
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
section gapinthsub_statements
                                                    
def test1_before := [llvm|
{
^0(%arg26 : i23):
  %0 = llvm.sub %arg26, %arg26 : i23
  "llvm.return"(%0) : (i23) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg26 : i23):
  %0 = "llvm.mlir.constant"() <{value = 0 : i23}> : () -> i23
  "llvm.return"(%0) : (i23) -> ()
}
]
theorem test1_proof : test1_before ⊑ test1_after := by
  unfold test1_before test1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN test1
  all_goals (try extract_goal ; sorry)
  ---END test1



def test2_before := [llvm|
{
^0(%arg25 : i47):
  %0 = "llvm.mlir.constant"() <{value = 0 : i47}> : () -> i47
  %1 = llvm.sub %arg25, %0 : i47
  "llvm.return"(%1) : (i47) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg25 : i47):
  "llvm.return"(%arg25) : (i47) -> ()
}
]
theorem test2_proof : test2_before ⊑ test2_after := by
  unfold test2_before test2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN test2
  all_goals (try extract_goal ; sorry)
  ---END test2



def test3_before := [llvm|
{
^0(%arg24 : i97):
  %0 = "llvm.mlir.constant"() <{value = 0 : i97}> : () -> i97
  %1 = llvm.sub %0, %arg24 : i97
  %2 = llvm.sub %0, %1 : i97
  "llvm.return"(%2) : (i97) -> ()
}
]
def test3_after := [llvm|
{
^0(%arg24 : i97):
  "llvm.return"(%arg24) : (i97) -> ()
}
]
theorem test3_proof : test3_before ⊑ test3_after := by
  unfold test3_before test3_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN test3
  all_goals (try extract_goal ; sorry)
  ---END test3



def test4_before := [llvm|
{
^0(%arg22 : i108, %arg23 : i108):
  %0 = "llvm.mlir.constant"() <{value = 0 : i108}> : () -> i108
  %1 = llvm.sub %0, %arg22 : i108
  %2 = llvm.sub %arg23, %1 : i108
  "llvm.return"(%2) : (i108) -> ()
}
]
def test4_after := [llvm|
{
^0(%arg22 : i108, %arg23 : i108):
  %0 = llvm.add %arg23, %arg22 : i108
  "llvm.return"(%0) : (i108) -> ()
}
]
theorem test4_proof : test4_before ⊑ test4_after := by
  unfold test4_before test4_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN test4
  all_goals (try extract_goal ; sorry)
  ---END test4



def test5_before := [llvm|
{
^0(%arg19 : i19, %arg20 : i19, %arg21 : i19):
  %0 = llvm.sub %arg20, %arg21 : i19
  %1 = llvm.sub %arg19, %0 : i19
  "llvm.return"(%1) : (i19) -> ()
}
]
def test5_after := [llvm|
{
^0(%arg19 : i19, %arg20 : i19, %arg21 : i19):
  %0 = llvm.sub %arg21, %arg20 : i19
  %1 = llvm.add %0, %arg19 : i19
  "llvm.return"(%1) : (i19) -> ()
}
]
theorem test5_proof : test5_before ⊑ test5_after := by
  unfold test5_before test5_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN test5
  all_goals (try extract_goal ; sorry)
  ---END test5



def test6_before := [llvm|
{
^0(%arg17 : i57, %arg18 : i57):
  %0 = llvm.and %arg17, %arg18 : i57
  %1 = llvm.sub %arg17, %0 : i57
  "llvm.return"(%1) : (i57) -> ()
}
]
def test6_after := [llvm|
{
^0(%arg17 : i57, %arg18 : i57):
  %0 = "llvm.mlir.constant"() <{value = -1 : i57}> : () -> i57
  %1 = llvm.xor %arg18, %0 : i57
  %2 = llvm.and %arg17, %1 : i57
  "llvm.return"(%2) : (i57) -> ()
}
]
theorem test6_proof : test6_before ⊑ test6_after := by
  unfold test6_before test6_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN test6
  all_goals (try extract_goal ; sorry)
  ---END test6



def test7_before := [llvm|
{
^0(%arg16 : i77):
  %0 = "llvm.mlir.constant"() <{value = -1 : i77}> : () -> i77
  %1 = llvm.sub %0, %arg16 : i77
  "llvm.return"(%1) : (i77) -> ()
}
]
def test7_after := [llvm|
{
^0(%arg16 : i77):
  %0 = "llvm.mlir.constant"() <{value = -1 : i77}> : () -> i77
  %1 = llvm.xor %arg16, %0 : i77
  "llvm.return"(%1) : (i77) -> ()
}
]
theorem test7_proof : test7_before ⊑ test7_after := by
  unfold test7_before test7_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN test7
  all_goals (try extract_goal ; sorry)
  ---END test7



def test8_before := [llvm|
{
^0(%arg15 : i27):
  %0 = "llvm.mlir.constant"() <{value = 9 : i27}> : () -> i27
  %1 = llvm.mul %0, %arg15 : i27
  %2 = llvm.sub %1, %arg15 : i27
  "llvm.return"(%2) : (i27) -> ()
}
]
def test8_after := [llvm|
{
^0(%arg15 : i27):
  %0 = "llvm.mlir.constant"() <{value = 3 : i27}> : () -> i27
  %1 = llvm.shl %arg15, %0 : i27
  "llvm.return"(%1) : (i27) -> ()
}
]
theorem test8_proof : test8_before ⊑ test8_after := by
  unfold test8_before test8_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN test8
  all_goals (try extract_goal ; sorry)
  ---END test8



def test9_before := [llvm|
{
^0(%arg14 : i42):
  %0 = "llvm.mlir.constant"() <{value = 3 : i42}> : () -> i42
  %1 = llvm.mul %0, %arg14 : i42
  %2 = llvm.sub %arg14, %1 : i42
  "llvm.return"(%2) : (i42) -> ()
}
]
def test9_after := [llvm|
{
^0(%arg14 : i42):
  %0 = "llvm.mlir.constant"() <{value = -2 : i42}> : () -> i42
  %1 = llvm.mul %arg14, %0 : i42
  "llvm.return"(%1) : (i42) -> ()
}
]
theorem test9_proof : test9_before ⊑ test9_after := by
  unfold test9_before test9_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN test9
  all_goals (try extract_goal ; sorry)
  ---END test9



def test12_before := [llvm|
{
^0(%arg11 : i43):
  %0 = "llvm.mlir.constant"() <{value = 42 : i43}> : () -> i43
  %1 = "llvm.mlir.constant"() <{value = 0 : i43}> : () -> i43
  %2 = llvm.ashr %arg11, %0 : i43
  %3 = llvm.sub %1, %2 : i43
  "llvm.return"(%3) : (i43) -> ()
}
]
def test12_after := [llvm|
{
^0(%arg11 : i43):
  %0 = "llvm.mlir.constant"() <{value = 42 : i43}> : () -> i43
  %1 = llvm.lshr %arg11, %0 : i43
  "llvm.return"(%1) : (i43) -> ()
}
]
theorem test12_proof : test12_before ⊑ test12_after := by
  unfold test12_before test12_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN test12
  all_goals (try extract_goal ; sorry)
  ---END test12



def test13_before := [llvm|
{
^0(%arg10 : i79):
  %0 = "llvm.mlir.constant"() <{value = 78 : i79}> : () -> i79
  %1 = "llvm.mlir.constant"() <{value = 0 : i79}> : () -> i79
  %2 = llvm.lshr %arg10, %0 : i79
  %3 = llvm.sub %1, %2 : i79
  "llvm.return"(%3) : (i79) -> ()
}
]
def test13_after := [llvm|
{
^0(%arg10 : i79):
  %0 = "llvm.mlir.constant"() <{value = 78 : i79}> : () -> i79
  %1 = llvm.ashr %arg10, %0 : i79
  "llvm.return"(%1) : (i79) -> ()
}
]
theorem test13_proof : test13_before ⊑ test13_after := by
  unfold test13_before test13_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN test13
  all_goals (try extract_goal ; sorry)
  ---END test13



def test16_before := [llvm|
{
^0(%arg8 : i51):
  %0 = "llvm.mlir.constant"() <{value = 1123 : i51}> : () -> i51
  %1 = "llvm.mlir.constant"() <{value = 0 : i51}> : () -> i51
  %2 = llvm.sdiv %arg8, %0 : i51
  %3 = llvm.sub %1, %2 : i51
  "llvm.return"(%3) : (i51) -> ()
}
]
def test16_after := [llvm|
{
^0(%arg8 : i51):
  %0 = "llvm.mlir.constant"() <{value = -1123 : i51}> : () -> i51
  %1 = llvm.sdiv %arg8, %0 : i51
  "llvm.return"(%1) : (i51) -> ()
}
]
theorem test16_proof : test16_before ⊑ test16_after := by
  unfold test16_before test16_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN test16
  all_goals (try extract_goal ; sorry)
  ---END test16



def test18_before := [llvm|
{
^0(%arg6 : i128):
  %0 = "llvm.mlir.constant"() <{value = 2 : i128}> : () -> i128
  %1 = llvm.shl %arg6, %0 : i128
  %2 = llvm.shl %arg6, %0 : i128
  %3 = llvm.sub %1, %2 : i128
  "llvm.return"(%3) : (i128) -> ()
}
]
def test18_after := [llvm|
{
^0(%arg6 : i128):
  %0 = "llvm.mlir.constant"() <{value = 0 : i128}> : () -> i128
  "llvm.return"(%0) : (i128) -> ()
}
]
theorem test18_proof : test18_before ⊑ test18_after := by
  unfold test18_before test18_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN test18
  all_goals (try extract_goal ; sorry)
  ---END test18



def test19_before := [llvm|
{
^0(%arg4 : i39, %arg5 : i39):
  %0 = llvm.sub %arg4, %arg5 : i39
  %1 = llvm.add %0, %arg5 : i39
  "llvm.return"(%1) : (i39) -> ()
}
]
def test19_after := [llvm|
{
^0(%arg4 : i39, %arg5 : i39):
  "llvm.return"(%arg4) : (i39) -> ()
}
]
theorem test19_proof : test19_before ⊑ test19_after := by
  unfold test19_before test19_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN test19
  all_goals (try extract_goal ; sorry)
  ---END test19


