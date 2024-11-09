import SSA.Projects.InstCombine.tests.proofs.gcomparehudiv_proof
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
section gcomparehudiv_statements

def test1_before := [llvm|
{
^0(%arg34 : i32, %arg35 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.udiv %arg34, %arg35 : i32
  %2 = llvm.icmp "eq" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg34 : i32, %arg35 : i32):
  %0 = llvm.icmp "ugt" %arg35, %arg34 : i32
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test1_proof : test1_before ⊑ test1_after := by
  unfold test1_before test1_after
  simp_alive_peephole
  intros
  ---BEGIN test1
  apply test1_thm
  ---END test1



def test2_before := [llvm|
{
^0(%arg31 : i32):
  %0 = llvm.mlir.constant(64 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.udiv %0, %arg31 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg31 : i32):
  %0 = llvm.mlir.constant(64 : i32) : i32
  %1 = llvm.icmp "ugt" %arg31, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test2_proof : test2_before ⊑ test2_after := by
  unfold test2_before test2_after
  simp_alive_peephole
  intros
  ---BEGIN test2
  apply test2_thm
  ---END test2



def test3_before := [llvm|
{
^0(%arg28 : i32, %arg29 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.udiv %arg28, %arg29 : i32
  %2 = llvm.icmp "ne" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def test3_after := [llvm|
{
^0(%arg28 : i32, %arg29 : i32):
  %0 = llvm.icmp "ule" %arg29, %arg28 : i32
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test3_proof : test3_before ⊑ test3_after := by
  unfold test3_before test3_after
  simp_alive_peephole
  intros
  ---BEGIN test3
  apply test3_thm
  ---END test3



def test4_before := [llvm|
{
^0(%arg25 : i32):
  %0 = llvm.mlir.constant(64 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.udiv %0, %arg25 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def test4_after := [llvm|
{
^0(%arg25 : i32):
  %0 = llvm.mlir.constant(65 : i32) : i32
  %1 = llvm.icmp "ult" %arg25, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test4_proof : test4_before ⊑ test4_after := by
  unfold test4_before test4_after
  simp_alive_peephole
  intros
  ---BEGIN test4
  apply test4_thm
  ---END test4



def test5_before := [llvm|
{
^0(%arg23 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.udiv %0, %arg23 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def test5_after := [llvm|
{
^0(%arg23 : i32):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test5_proof : test5_before ⊑ test5_after := by
  unfold test5_before test5_after
  simp_alive_peephole
  intros
  ---BEGIN test5
  apply test5_thm
  ---END test5



def test6_before := [llvm|
{
^0(%arg21 : i32):
  %0 = llvm.mlir.constant(5 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.udiv %0, %arg21 : i32
  %3 = llvm.icmp "ugt" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def test6_after := [llvm|
{
^0(%arg21 : i32):
  %0 = llvm.mlir.constant(6 : i32) : i32
  %1 = llvm.icmp "ult" %arg21, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test6_proof : test6_before ⊑ test6_after := by
  unfold test6_before test6_after
  simp_alive_peephole
  intros
  ---BEGIN test6
  apply test6_thm
  ---END test6



def test7_before := [llvm|
{
^0(%arg19 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.udiv %0, %arg19 : i32
  %2 = llvm.icmp "ugt" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def test7_after := [llvm|
{
^0(%arg19 : i32):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test7_proof : test7_before ⊑ test7_after := by
  unfold test7_before test7_after
  simp_alive_peephole
  intros
  ---BEGIN test7
  apply test7_thm
  ---END test7



def test8_before := [llvm|
{
^0(%arg17 : i32):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.mlir.constant(3 : i32) : i32
  %2 = llvm.udiv %0, %arg17 : i32
  %3 = llvm.icmp "ugt" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def test8_after := [llvm|
{
^0(%arg17 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.icmp "ult" %arg17, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test8_proof : test8_before ⊑ test8_after := by
  unfold test8_before test8_after
  simp_alive_peephole
  intros
  ---BEGIN test8
  apply test8_thm
  ---END test8



def test9_before := [llvm|
{
^0(%arg15 : i32):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.udiv %0, %arg15 : i32
  %3 = llvm.icmp "ugt" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def test9_after := [llvm|
{
^0(%arg15 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.icmp "ult" %arg15, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test9_proof : test9_before ⊑ test9_after := by
  unfold test9_before test9_after
  simp_alive_peephole
  intros
  ---BEGIN test9
  apply test9_thm
  ---END test9



def test10_before := [llvm|
{
^0(%arg13 : i32):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.udiv %0, %arg13 : i32
  %3 = llvm.icmp "ugt" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def test10_after := [llvm|
{
^0(%arg13 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.icmp "ult" %arg13, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test10_proof : test10_before ⊑ test10_after := by
  unfold test10_before test10_after
  simp_alive_peephole
  intros
  ---BEGIN test10
  apply test10_thm
  ---END test10



def test11_before := [llvm|
{
^0(%arg11 : i32):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.udiv %0, %arg11 : i32
  %3 = llvm.icmp "ult" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def test11_after := [llvm|
{
^0(%arg11 : i32):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.icmp "ugt" %arg11, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test11_proof : test11_before ⊑ test11_after := by
  unfold test11_before test11_after
  simp_alive_peephole
  intros
  ---BEGIN test11
  apply test11_thm
  ---END test11



def test12_before := [llvm|
{
^0(%arg9 : i32):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.udiv %0, %arg9 : i32
  %3 = llvm.icmp "ult" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def test12_after := [llvm|
{
^0(%arg9 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.icmp "ugt" %arg9, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test12_proof : test12_before ⊑ test12_after := by
  unfold test12_before test12_after
  simp_alive_peephole
  intros
  ---BEGIN test12
  apply test12_thm
  ---END test12



def test13_before := [llvm|
{
^0(%arg7 : i32):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.mlir.constant(3 : i32) : i32
  %2 = llvm.udiv %0, %arg7 : i32
  %3 = llvm.icmp "ult" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def test13_after := [llvm|
{
^0(%arg7 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.icmp "ugt" %arg7, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test13_proof : test13_before ⊑ test13_after := by
  unfold test13_before test13_after
  simp_alive_peephole
  intros
  ---BEGIN test13
  apply test13_thm
  ---END test13



def test14_before := [llvm|
{
^0(%arg5 : i32):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.udiv %0, %arg5 : i32
  %2 = llvm.icmp "ult" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def test14_after := [llvm|
{
^0(%arg5 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.icmp "ugt" %arg5, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test14_proof : test14_before ⊑ test14_after := by
  unfold test14_before test14_after
  simp_alive_peephole
  intros
  ---BEGIN test14
  apply test14_thm
  ---END test14



def test15_before := [llvm|
{
^0(%arg3 : i32):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.udiv %0, %arg3 : i32
  %3 = llvm.icmp "ugt" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def test15_after := [llvm|
{
^0(%arg3 : i32):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test15_proof : test15_before ⊑ test15_after := by
  unfold test15_before test15_after
  simp_alive_peephole
  intros
  ---BEGIN test15
  apply test15_thm
  ---END test15



def test16_before := [llvm|
{
^0(%arg1 : i32):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.udiv %0, %arg1 : i32
  %3 = llvm.icmp "ult" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def test16_after := [llvm|
{
^0(%arg1 : i32):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test16_proof : test16_before ⊑ test16_after := by
  unfold test16_before test16_after
  simp_alive_peephole
  intros
  ---BEGIN test16
  apply test16_thm
  ---END test16


