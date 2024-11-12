
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
section gapinthxor2_statements

def test1_before := [llvm|
{
^0(%arg6 : i447, %arg7 : i447):
  %0 = llvm.mlir.constant(70368744177664 : i447) : i447
  %1 = llvm.mlir.constant(70368744177663 : i447) : i447
  %2 = llvm.and %arg6, %0 : i447
  %3 = llvm.and %arg7, %1 : i447
  %4 = llvm.xor %2, %3 : i447
  "llvm.return"(%4) : (i447) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg6 : i447, %arg7 : i447):
  %0 = llvm.mlir.constant(70368744177664 : i447) : i447
  %1 = llvm.mlir.constant(70368744177663 : i447) : i447
  %2 = llvm.and %arg6, %0 : i447
  %3 = llvm.and %arg7, %1 : i447
  %4 = llvm.or disjoint %2, %3 : i447
  "llvm.return"(%4) : (i447) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test1_proof : test1_before ⊑ test1_after := by
  unfold test1_before test1_after
  simp_alive_peephole
  intros
  ---BEGIN test1
  all_goals (try extract_goal ; sorry)
  ---END test1



def test2_before := [llvm|
{
^0(%arg5 : i1005):
  %0 = llvm.mlir.constant(0 : i1005) : i1005
  %1 = llvm.xor %arg5, %0 : i1005
  "llvm.return"(%1) : (i1005) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg5 : i1005):
  "llvm.return"(%arg5) : (i1005) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test2_proof : test2_before ⊑ test2_after := by
  unfold test2_before test2_after
  simp_alive_peephole
  intros
  ---BEGIN test2
  all_goals (try extract_goal ; sorry)
  ---END test2



def test3_before := [llvm|
{
^0(%arg4 : i123):
  %0 = llvm.xor %arg4, %arg4 : i123
  "llvm.return"(%0) : (i123) -> ()
}
]
def test3_after := [llvm|
{
^0(%arg4 : i123):
  %0 = llvm.mlir.constant(0 : i123) : i123
  "llvm.return"(%0) : (i123) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test3_proof : test3_before ⊑ test3_after := by
  unfold test3_before test3_after
  simp_alive_peephole
  intros
  ---BEGIN test3
  all_goals (try extract_goal ; sorry)
  ---END test3



def test4_before := [llvm|
{
^0(%arg3 : i737):
  %0 = llvm.mlir.constant(-1 : i737) : i737
  %1 = llvm.xor %0, %arg3 : i737
  %2 = llvm.xor %arg3, %1 : i737
  "llvm.return"(%2) : (i737) -> ()
}
]
def test4_after := [llvm|
{
^0(%arg3 : i737):
  %0 = llvm.mlir.constant(-1 : i737) : i737
  "llvm.return"(%0) : (i737) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test4_proof : test4_before ⊑ test4_after := by
  unfold test4_before test4_after
  simp_alive_peephole
  intros
  ---BEGIN test4
  all_goals (try extract_goal ; sorry)
  ---END test4



def test5_before := [llvm|
{
^0(%arg2 : i700):
  %0 = llvm.mlir.constant(288230376151711743 : i700) : i700
  %1 = llvm.or %arg2, %0 : i700
  %2 = llvm.xor %1, %0 : i700
  "llvm.return"(%2) : (i700) -> ()
}
]
def test5_after := [llvm|
{
^0(%arg2 : i700):
  %0 = llvm.mlir.constant(-288230376151711744 : i700) : i700
  %1 = llvm.and %arg2, %0 : i700
  "llvm.return"(%1) : (i700) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test5_proof : test5_before ⊑ test5_after := by
  unfold test5_before test5_after
  simp_alive_peephole
  intros
  ---BEGIN test5
  all_goals (try extract_goal ; sorry)
  ---END test5



def test6_before := [llvm|
{
^0(%arg1 : i77):
  %0 = llvm.mlir.constant(23 : i77) : i77
  %1 = llvm.xor %arg1, %0 : i77
  %2 = llvm.xor %1, %0 : i77
  "llvm.return"(%2) : (i77) -> ()
}
]
def test6_after := [llvm|
{
^0(%arg1 : i77):
  "llvm.return"(%arg1) : (i77) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test6_proof : test6_before ⊑ test6_after := by
  unfold test6_before test6_after
  simp_alive_peephole
  intros
  ---BEGIN test6
  all_goals (try extract_goal ; sorry)
  ---END test6



def test7_before := [llvm|
{
^0(%arg0 : i1023):
  %0 = llvm.mlir.constant(70368744177663 : i1023) : i1023
  %1 = llvm.mlir.constant(703687463 : i1023) : i1023
  %2 = llvm.or %arg0, %0 : i1023
  %3 = llvm.xor %2, %1 : i1023
  "llvm.return"(%3) : (i1023) -> ()
}
]
def test7_after := [llvm|
{
^0(%arg0 : i1023):
  %0 = llvm.mlir.constant(-70368744177664 : i1023) : i1023
  %1 = llvm.mlir.constant(70368040490200 : i1023) : i1023
  %2 = llvm.and %arg0, %0 : i1023
  %3 = llvm.or disjoint %2, %1 : i1023
  "llvm.return"(%3) : (i1023) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test7_proof : test7_before ⊑ test7_after := by
  unfold test7_before test7_after
  simp_alive_peephole
  intros
  ---BEGIN test7
  all_goals (try extract_goal ; sorry)
  ---END test7


