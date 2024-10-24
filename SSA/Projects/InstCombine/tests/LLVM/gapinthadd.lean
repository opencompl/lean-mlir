
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
section gapinthadd_statements

def test1_before := [llvm|
{
^0(%arg12 : i1):
  %0 = "llvm.mlir.constant"() <{value = true}> : () -> i1
  %1 = llvm.xor %arg12, %0 : i1
  %2 = llvm.add %1, %0 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg12 : i1):
  "llvm.return"(%arg12) : (i1) -> ()
}
]
theorem test1_proof : test1_before ⊑ test1_after := by
  unfold test1_before test1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN test1
  all_goals (try extract_goal ; sorry)
  ---END test1



def test2_before := [llvm|
{
^0(%arg11 : i47):
  %0 = "llvm.mlir.constant"() <{value = -70368744177664 : i47}> : () -> i47
  %1 = llvm.xor %arg11, %0 : i47
  %2 = llvm.add %1, %0 : i47
  "llvm.return"(%2) : (i47) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg11 : i47):
  "llvm.return"(%arg11) : (i47) -> ()
}
]
theorem test2_proof : test2_before ⊑ test2_after := by
  unfold test2_before test2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN test2
  all_goals (try extract_goal ; sorry)
  ---END test2



def test3_before := [llvm|
{
^0(%arg10 : i15):
  %0 = "llvm.mlir.constant"() <{value = -16384 : i15}> : () -> i15
  %1 = llvm.xor %arg10, %0 : i15
  %2 = llvm.add %1, %0 : i15
  "llvm.return"(%2) : (i15) -> ()
}
]
def test3_after := [llvm|
{
^0(%arg10 : i15):
  "llvm.return"(%arg10) : (i15) -> ()
}
]
theorem test3_proof : test3_before ⊑ test3_after := by
  unfold test3_before test3_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN test3
  all_goals (try extract_goal ; sorry)
  ---END test3



def test4_before := [llvm|
{
^0(%arg8 : i49):
  %0 = "llvm.mlir.constant"() <{value = -2 : i49}> : () -> i49
  %1 = "llvm.mlir.constant"() <{value = 1 : i49}> : () -> i49
  %2 = llvm.and %arg8, %0 : i49
  %3 = llvm.add %2, %1 : i49
  "llvm.return"(%3) : (i49) -> ()
}
]
def test4_after := [llvm|
{
^0(%arg8 : i49):
  %0 = "llvm.mlir.constant"() <{value = 1 : i49}> : () -> i49
  %1 = llvm.or %arg8, %0 : i49
  "llvm.return"(%1) : (i49) -> ()
}
]
theorem test4_proof : test4_before ⊑ test4_after := by
  unfold test4_before test4_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN test4
  all_goals (try extract_goal ; sorry)
  ---END test4



def test5_before := [llvm|
{
^0(%arg4 : i111):
  %0 = "llvm.mlir.constant"() <{value = 1 : i111}> : () -> i111
  %1 = "llvm.mlir.constant"() <{value = 110 : i111}> : () -> i111
  %2 = llvm.shl %0, %1 : i111
  %3 = llvm.xor %arg4, %2 : i111
  %4 = llvm.add %3, %2 : i111
  "llvm.return"(%4) : (i111) -> ()
}
]
def test5_after := [llvm|
{
^0(%arg4 : i111):
  "llvm.return"(%arg4) : (i111) -> ()
}
]
theorem test5_proof : test5_before ⊑ test5_after := by
  unfold test5_before test5_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN test5
  all_goals (try extract_goal ; sorry)
  ---END test5



def test6_before := [llvm|
{
^0(%arg3 : i65):
  %0 = "llvm.mlir.constant"() <{value = 1 : i65}> : () -> i65
  %1 = "llvm.mlir.constant"() <{value = 64 : i65}> : () -> i65
  %2 = llvm.shl %0, %1 : i65
  %3 = llvm.xor %arg3, %2 : i65
  %4 = llvm.add %3, %2 : i65
  "llvm.return"(%4) : (i65) -> ()
}
]
def test6_after := [llvm|
{
^0(%arg3 : i65):
  "llvm.return"(%arg3) : (i65) -> ()
}
]
theorem test6_proof : test6_before ⊑ test6_after := by
  unfold test6_before test6_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN test6
  all_goals (try extract_goal ; sorry)
  ---END test6



def test7_before := [llvm|
{
^0(%arg2 : i1024):
  %0 = "llvm.mlir.constant"() <{value = 1 : i1024}> : () -> i1024
  %1 = "llvm.mlir.constant"() <{value = 1023 : i1024}> : () -> i1024
  %2 = llvm.shl %0, %1 : i1024
  %3 = llvm.xor %arg2, %2 : i1024
  %4 = llvm.add %3, %2 : i1024
  "llvm.return"(%4) : (i1024) -> ()
}
]
def test7_after := [llvm|
{
^0(%arg2 : i1024):
  "llvm.return"(%arg2) : (i1024) -> ()
}
]
theorem test7_proof : test7_before ⊑ test7_after := by
  unfold test7_before test7_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN test7
  all_goals (try extract_goal ; sorry)
  ---END test7



def test8_before := [llvm|
{
^0(%arg1 : i128):
  %0 = "llvm.mlir.constant"() <{value = 1 : i128}> : () -> i128
  %1 = "llvm.mlir.constant"() <{value = 127 : i128}> : () -> i128
  %2 = "llvm.mlir.constant"() <{value = 120 : i128}> : () -> i128
  %3 = llvm.shl %0, %1 : i128
  %4 = llvm.ashr %3, %2 : i128
  %5 = llvm.xor %arg1, %4 : i128
  %6 = llvm.add %5, %3 : i128
  "llvm.return"(%6) : (i128) -> ()
}
]
def test8_after := [llvm|
{
^0(%arg1 : i128):
  %0 = "llvm.mlir.constant"() <{value = 170141183460469231731687303715884105600 : i128}> : () -> i128
  %1 = llvm.xor %arg1, %0 : i128
  "llvm.return"(%1) : (i128) -> ()
}
]
theorem test8_proof : test8_before ⊑ test8_after := by
  unfold test8_before test8_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN test8
  all_goals (try extract_goal ; sorry)
  ---END test8



def test9_before := [llvm|
{
^0(%arg0 : i77):
  %0 = "llvm.mlir.constant"() <{value = 562949953421310 : i77}> : () -> i77
  %1 = "llvm.mlir.constant"() <{value = 1 : i77}> : () -> i77
  %2 = llvm.and %arg0, %0 : i77
  %3 = llvm.add %2, %1 : i77
  "llvm.return"(%3) : (i77) -> ()
}
]
def test9_after := [llvm|
{
^0(%arg0 : i77):
  %0 = "llvm.mlir.constant"() <{value = 562949953421310 : i77}> : () -> i77
  %1 = "llvm.mlir.constant"() <{value = 1 : i77}> : () -> i77
  %2 = llvm.and %arg0, %0 : i77
  %3 = llvm.or %2, %1 : i77
  "llvm.return"(%3) : (i77) -> ()
}
]
theorem test9_proof : test9_before ⊑ test9_after := by
  unfold test9_before test9_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN test9
  all_goals (try extract_goal ; sorry)
  ---END test9


