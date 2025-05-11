
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
section gapinthand_statements

def test0_before := [llvm|
{
^0(%arg13 : i39):
  %0 = llvm.mlir.constant(0 : i39) : i39
  %1 = llvm.and %arg13, %0 : i39
  "llvm.return"(%1) : (i39) -> ()
}
]
def test0_after := [llvm|
{
^0(%arg13 : i39):
  %0 = llvm.mlir.constant(0 : i39) : i39
  "llvm.return"(%0) : (i39) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test0_proof : test0_before ⊑ test0_after := by
  unfold test0_before test0_after
  simp_alive_peephole
  intros
  ---BEGIN test0
  all_goals (try extract_goal ; sorry)
  ---END test0



def test2_before := [llvm|
{
^0(%arg12 : i15):
  %0 = llvm.mlir.constant(-1 : i15) : i15
  %1 = llvm.and %arg12, %0 : i15
  "llvm.return"(%1) : (i15) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg12 : i15):
  "llvm.return"(%arg12) : (i15) -> ()
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
^0(%arg11 : i23):
  %0 = llvm.mlir.constant(127 : i23) : i23
  %1 = llvm.mlir.constant(128 : i23) : i23
  %2 = llvm.and %arg11, %0 : i23
  %3 = llvm.and %2, %1 : i23
  "llvm.return"(%3) : (i23) -> ()
}
]
def test3_after := [llvm|
{
^0(%arg11 : i23):
  %0 = llvm.mlir.constant(0 : i23) : i23
  "llvm.return"(%0) : (i23) -> ()
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
^0(%arg10 : i37):
  %0 = llvm.mlir.constant(-2147483648 : i37) : i37
  %1 = llvm.mlir.constant(0 : i37) : i37
  %2 = llvm.and %arg10, %0 : i37
  %3 = llvm.icmp "ne" %2, %1 : i37
  "llvm.return"(%3) : (i1) -> ()
}
]
def test4_after := [llvm|
{
^0(%arg10 : i37):
  %0 = llvm.mlir.constant(2147483647 : i37) : i37
  %1 = llvm.icmp "ugt" %arg10, %0 : i37
  "llvm.return"(%1) : (i1) -> ()
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



def test7_before := [llvm|
{
^0(%arg7 : i47):
  %0 = llvm.mlir.constant(39 : i47) : i47
  %1 = llvm.mlir.constant(255 : i47) : i47
  %2 = llvm.ashr %arg7, %0 : i47
  %3 = llvm.and %2, %1 : i47
  "llvm.return"(%3) : (i47) -> ()
}
]
def test7_after := [llvm|
{
^0(%arg7 : i47):
  %0 = llvm.mlir.constant(39 : i47) : i47
  %1 = llvm.lshr %arg7, %0 : i47
  "llvm.return"(%1) : (i47) -> ()
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



def test8_before := [llvm|
{
^0(%arg6 : i999):
  %0 = llvm.mlir.constant(0 : i999) : i999
  %1 = llvm.and %arg6, %0 : i999
  "llvm.return"(%1) : (i999) -> ()
}
]
def test8_after := [llvm|
{
^0(%arg6 : i999):
  %0 = llvm.mlir.constant(0 : i999) : i999
  "llvm.return"(%0) : (i999) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test8_proof : test8_before ⊑ test8_after := by
  unfold test8_before test8_after
  simp_alive_peephole
  intros
  ---BEGIN test8
  all_goals (try extract_goal ; sorry)
  ---END test8



def test9_before := [llvm|
{
^0(%arg5 : i1005):
  %0 = llvm.mlir.constant(-1 : i1005) : i1005
  %1 = llvm.and %arg5, %0 : i1005
  "llvm.return"(%1) : (i1005) -> ()
}
]
def test9_after := [llvm|
{
^0(%arg5 : i1005):
  "llvm.return"(%arg5) : (i1005) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test9_proof : test9_before ⊑ test9_after := by
  unfold test9_before test9_after
  simp_alive_peephole
  intros
  ---BEGIN test9
  all_goals (try extract_goal ; sorry)
  ---END test9



def test10_before := [llvm|
{
^0(%arg4 : i123):
  %0 = llvm.mlir.constant(127 : i123) : i123
  %1 = llvm.mlir.constant(128 : i123) : i123
  %2 = llvm.and %arg4, %0 : i123
  %3 = llvm.and %2, %1 : i123
  "llvm.return"(%3) : (i123) -> ()
}
]
def test10_after := [llvm|
{
^0(%arg4 : i123):
  %0 = llvm.mlir.constant(0 : i123) : i123
  "llvm.return"(%0) : (i123) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test10_proof : test10_before ⊑ test10_after := by
  unfold test10_before test10_after
  simp_alive_peephole
  intros
  ---BEGIN test10
  all_goals (try extract_goal ; sorry)
  ---END test10



def test11_before := [llvm|
{
^0(%arg3 : i737):
  %0 = llvm.mlir.constant(-2147483648 : i737) : i737
  %1 = llvm.mlir.constant(0 : i737) : i737
  %2 = llvm.and %arg3, %0 : i737
  %3 = llvm.icmp "ne" %2, %1 : i737
  "llvm.return"(%3) : (i1) -> ()
}
]
def test11_after := [llvm|
{
^0(%arg3 : i737):
  %0 = llvm.mlir.constant(2147483647 : i737) : i737
  %1 = llvm.icmp "ugt" %arg3, %0 : i737
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test11_proof : test11_before ⊑ test11_after := by
  unfold test11_before test11_after
  simp_alive_peephole
  intros
  ---BEGIN test11
  all_goals (try extract_goal ; sorry)
  ---END test11



def test13_before := [llvm|
{
^0(%arg0 : i1024):
  %0 = llvm.mlir.constant(1016 : i1024) : i1024
  %1 = llvm.mlir.constant(255 : i1024) : i1024
  %2 = llvm.ashr %arg0, %0 : i1024
  %3 = llvm.and %2, %1 : i1024
  "llvm.return"(%3) : (i1024) -> ()
}
]
def test13_after := [llvm|
{
^0(%arg0 : i1024):
  %0 = llvm.mlir.constant(1016 : i1024) : i1024
  %1 = llvm.lshr %arg0, %0 : i1024
  "llvm.return"(%1) : (i1024) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test13_proof : test13_before ⊑ test13_after := by
  unfold test13_before test13_after
  simp_alive_peephole
  intros
  ---BEGIN test13
  all_goals (try extract_goal ; sorry)
  ---END test13


