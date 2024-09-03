import SSA.Projects.InstCombine.tests.LLVM.gapinthandhorhand_proof
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
section gapinthandhorhand_statements
                                                    
def test1_before := [llvm|
{
^0(%arg8 : i17, %arg9 : i17):
  %0 = "llvm.mlir.constant"() <{value = 7 : i17}> : () -> i17
  %1 = "llvm.mlir.constant"() <{value = 8 : i17}> : () -> i17
  %2 = llvm.and %arg8, %0 : i17
  %3 = llvm.and %arg9, %1 : i17
  %4 = llvm.or %2, %3 : i17
  %5 = llvm.and %4, %0 : i17
  "llvm.return"(%5) : (i17) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg8 : i17, %arg9 : i17):
  %0 = "llvm.mlir.constant"() <{value = 7 : i17}> : () -> i17
  %1 = llvm.and %arg8, %0 : i17
  "llvm.return"(%1) : (i17) -> ()
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
  apply test1_thm
  ---END test1



def test3_before := [llvm|
{
^0(%arg6 : i49, %arg7 : i49):
  %0 = "llvm.mlir.constant"() <{value = 1 : i49}> : () -> i49
  %1 = llvm.shl %arg7, %0 : i49
  %2 = llvm.or %arg6, %1 : i49
  %3 = llvm.and %2, %0 : i49
  "llvm.return"(%3) : (i49) -> ()
}
]
def test3_after := [llvm|
{
^0(%arg6 : i49, %arg7 : i49):
  %0 = "llvm.mlir.constant"() <{value = 1 : i49}> : () -> i49
  %1 = llvm.and %arg6, %0 : i49
  "llvm.return"(%1) : (i49) -> ()
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
  apply test3_thm
  ---END test3



def test4_before := [llvm|
{
^0(%arg4 : i67, %arg5 : i67):
  %0 = "llvm.mlir.constant"() <{value = 66 : i67}> : () -> i67
  %1 = "llvm.mlir.constant"() <{value = 2 : i67}> : () -> i67
  %2 = llvm.lshr %arg5, %0 : i67
  %3 = llvm.or %arg4, %2 : i67
  %4 = llvm.and %3, %1 : i67
  "llvm.return"(%4) : (i67) -> ()
}
]
def test4_after := [llvm|
{
^0(%arg4 : i67, %arg5 : i67):
  %0 = "llvm.mlir.constant"() <{value = 2 : i67}> : () -> i67
  %1 = llvm.and %arg4, %0 : i67
  "llvm.return"(%1) : (i67) -> ()
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
  apply test4_thm
  ---END test4



def or_test1_before := [llvm|
{
^0(%arg2 : i231, %arg3 : i231):
  %0 = "llvm.mlir.constant"() <{value = 1 : i231}> : () -> i231
  %1 = llvm.and %arg2, %0 : i231
  %2 = llvm.or %1, %0 : i231
  "llvm.return"(%2) : (i231) -> ()
}
]
def or_test1_after := [llvm|
{
^0(%arg2 : i231, %arg3 : i231):
  %0 = "llvm.mlir.constant"() <{value = 1 : i231}> : () -> i231
  "llvm.return"(%0) : (i231) -> ()
}
]
theorem or_test1_proof : or_test1_before ⊑ or_test1_after := by
  unfold or_test1_before or_test1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN or_test1
  apply or_test1_thm
  ---END or_test1



def or_test2_before := [llvm|
{
^0(%arg0 : i7, %arg1 : i7):
  %0 = "llvm.mlir.constant"() <{value = 6 : i7}> : () -> i7
  %1 = "llvm.mlir.constant"() <{value = -64 : i7}> : () -> i7
  %2 = llvm.shl %arg0, %0 : i7
  %3 = llvm.or %2, %1 : i7
  "llvm.return"(%3) : (i7) -> ()
}
]
def or_test2_after := [llvm|
{
^0(%arg0 : i7, %arg1 : i7):
  %0 = "llvm.mlir.constant"() <{value = -64 : i7}> : () -> i7
  "llvm.return"(%0) : (i7) -> ()
}
]
theorem or_test2_proof : or_test2_before ⊑ or_test2_after := by
  unfold or_test2_before or_test2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN or_test2
  apply or_test2_thm
  ---END or_test2


