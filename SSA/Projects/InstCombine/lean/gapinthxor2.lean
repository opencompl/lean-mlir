import SSA.Projects.InstCombine.lean.gapinthxor2_proof
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
                                                                       
def test1_before := [llvm|
{
^0(%arg0 : i447, %arg1 : i447):
  %0 = "llvm.mlir.constant"() <{value = 70368744177664 : i447}> : () -> i447
  %1 = "llvm.mlir.constant"() <{value = 70368744177663 : i447}> : () -> i447
  %2 = llvm.and %arg0, %0 : i447
  %3 = llvm.and %arg1, %1 : i447
  %4 = llvm.xor %2, %3 : i447
  "llvm.return"(%4) : (i447) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg0 : i447, %arg1 : i447):
  %0 = "llvm.mlir.constant"() <{value = 70368744177664 : i447}> : () -> i447
  %1 = "llvm.mlir.constant"() <{value = 70368744177663 : i447}> : () -> i447
  %2 = llvm.and %arg0, %0 : i447
  %3 = llvm.and %arg1, %1 : i447
  %4 = llvm.or %2, %3 : i447
  "llvm.return"(%4) : (i447) -> ()
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
  apply test1_thm
  ---END test1



def test2_before := [llvm|
{
^0(%arg0 : i1005):
  %0 = "llvm.mlir.constant"() <{value = 0 : i1005}> : () -> i1005
  %1 = llvm.xor %arg0, %0 : i1005
  "llvm.return"(%1) : (i1005) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg0 : i1005):
  "llvm.return"(%arg0) : (i1005) -> ()
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
^0(%arg0 : i123):
  %0 = llvm.xor %arg0, %arg0 : i123
  "llvm.return"(%0) : (i123) -> ()
}
]
def test3_after := [llvm|
{
^0(%arg0 : i123):
  %0 = "llvm.mlir.constant"() <{value = 0 : i123}> : () -> i123
  "llvm.return"(%0) : (i123) -> ()
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
^0(%arg0 : i737):
  %0 = "llvm.mlir.constant"() <{value = -1 : i737}> : () -> i737
  %1 = llvm.xor %0, %arg0 : i737
  %2 = llvm.xor %arg0, %1 : i737
  "llvm.return"(%2) : (i737) -> ()
}
]
def test4_after := [llvm|
{
^0(%arg0 : i737):
  %0 = "llvm.mlir.constant"() <{value = -1 : i737}> : () -> i737
  "llvm.return"(%0) : (i737) -> ()
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
^0(%arg0 : i700):
  %0 = "llvm.mlir.constant"() <{value = 288230376151711743 : i700}> : () -> i700
  %1 = llvm.or %arg0, %0 : i700
  %2 = llvm.xor %1, %0 : i700
  "llvm.return"(%2) : (i700) -> ()
}
]
def test5_after := [llvm|
{
^0(%arg0 : i700):
  %0 = "llvm.mlir.constant"() <{value = -288230376151711744 : i700}> : () -> i700
  %1 = llvm.and %arg0, %0 : i700
  "llvm.return"(%1) : (i700) -> ()
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
^0(%arg0 : i77):
  %0 = "llvm.mlir.constant"() <{value = 23 : i77}> : () -> i77
  %1 = llvm.xor %arg0, %0 : i77
  %2 = llvm.xor %1, %0 : i77
  "llvm.return"(%2) : (i77) -> ()
}
]
def test6_after := [llvm|
{
^0(%arg0 : i77):
  "llvm.return"(%arg0) : (i77) -> ()
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
^0(%arg0 : i1023):
  %0 = "llvm.mlir.constant"() <{value = 70368744177663 : i1023}> : () -> i1023
  %1 = "llvm.mlir.constant"() <{value = 703687463 : i1023}> : () -> i1023
  %2 = llvm.or %arg0, %0 : i1023
  %3 = llvm.xor %2, %1 : i1023
  "llvm.return"(%3) : (i1023) -> ()
}
]
def test7_after := [llvm|
{
^0(%arg0 : i1023):
  %0 = "llvm.mlir.constant"() <{value = -70368744177664 : i1023}> : () -> i1023
  %1 = "llvm.mlir.constant"() <{value = 70368040490200 : i1023}> : () -> i1023
  %2 = llvm.and %arg0, %0 : i1023
  %3 = llvm.or %2, %1 : i1023
  "llvm.return"(%3) : (i1023) -> ()
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


