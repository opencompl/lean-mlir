import SSA.Projects.InstCombine.tests.proofs.gapinthadd_proof
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
  %0 = llvm.mlir.constant(true) : i1
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
^0(%arg11 : i47):
  %0 = llvm.mlir.constant(-70368744177664 : i47) : i47
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
^0(%arg10 : i15):
  %0 = llvm.mlir.constant(-16384 : i15) : i15
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
^0(%arg8 : i49):
  %0 = llvm.mlir.constant(-2 : i49) : i49
  %1 = llvm.mlir.constant(1 : i49) : i49
  %2 = llvm.and %arg8, %0 : i49
  %3 = llvm.add %2, %1 : i49
  "llvm.return"(%3) : (i49) -> ()
}
]
def test4_after := [llvm|
{
^0(%arg8 : i49):
  %0 = llvm.mlir.constant(1 : i49) : i49
  %1 = llvm.or %arg8, %0 : i49
  "llvm.return"(%1) : (i49) -> ()
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



def sext_before := [llvm|
{
^0(%arg7 : i4):
  %0 = llvm.mlir.constant(-8 : i4) : i4
  %1 = llvm.mlir.constant(-8 : i7) : i7
  %2 = llvm.xor %arg7, %0 : i4
  %3 = llvm.zext %2 : i4 to i7
  %4 = llvm.add %3, %1 overflow<nsw> : i7
  "llvm.return"(%4) : (i7) -> ()
}
]
def sext_after := [llvm|
{
^0(%arg7 : i4):
  %0 = llvm.sext %arg7 : i4 to i7
  "llvm.return"(%0) : (i7) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sext_proof : sext_before ⊑ sext_after := by
  unfold sext_before sext_after
  simp_alive_peephole
  intros
  ---BEGIN sext
  apply sext_thm
  ---END sext



def sext_multiuse_before := [llvm|
{
^0(%arg5 : i4):
  %0 = llvm.mlir.constant(-8 : i4) : i4
  %1 = llvm.mlir.constant(-8 : i7) : i7
  %2 = llvm.xor %arg5, %0 : i4
  %3 = llvm.zext %2 : i4 to i7
  %4 = llvm.add %3, %1 overflow<nsw> : i7
  %5 = llvm.sdiv %3, %4 : i7
  %6 = llvm.trunc %5 : i7 to i4
  %7 = llvm.sdiv %6, %2 : i4
  "llvm.return"(%7) : (i4) -> ()
}
]
def sext_multiuse_after := [llvm|
{
^0(%arg5 : i4):
  %0 = llvm.mlir.constant(-8 : i4) : i4
  %1 = llvm.xor %arg5, %0 : i4
  %2 = llvm.zext %1 : i4 to i7
  %3 = llvm.sext %arg5 : i4 to i7
  %4 = llvm.sdiv %2, %3 : i7
  %5 = llvm.trunc %4 : i7 to i4
  %6 = llvm.sdiv %5, %1 : i4
  "llvm.return"(%6) : (i4) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sext_multiuse_proof : sext_multiuse_before ⊑ sext_multiuse_after := by
  unfold sext_multiuse_before sext_multiuse_after
  simp_alive_peephole
  intros
  ---BEGIN sext_multiuse
  apply sext_multiuse_thm
  ---END sext_multiuse



def test5_before := [llvm|
{
^0(%arg4 : i111):
  %0 = llvm.mlir.constant(1 : i111) : i111
  %1 = llvm.mlir.constant(110 : i111) : i111
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
^0(%arg3 : i65):
  %0 = llvm.mlir.constant(1 : i65) : i65
  %1 = llvm.mlir.constant(64 : i65) : i65
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
^0(%arg2 : i1024):
  %0 = llvm.mlir.constant(1 : i1024) : i1024
  %1 = llvm.mlir.constant(1023 : i1024) : i1024
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
^0(%arg1 : i128):
  %0 = llvm.mlir.constant(1 : i128) : i128
  %1 = llvm.mlir.constant(127 : i128) : i128
  %2 = llvm.mlir.constant(120 : i128) : i128
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
  %0 = llvm.mlir.constant(170141183460469231731687303715884105600 : i128) : i128
  %1 = llvm.xor %arg1, %0 : i128
  "llvm.return"(%1) : (i128) -> ()
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
^0(%arg0 : i77):
  %0 = llvm.mlir.constant(562949953421310 : i77) : i77
  %1 = llvm.mlir.constant(1 : i77) : i77
  %2 = llvm.and %arg0, %0 : i77
  %3 = llvm.add %2, %1 : i77
  "llvm.return"(%3) : (i77) -> ()
}
]
def test9_after := [llvm|
{
^0(%arg0 : i77):
  %0 = llvm.mlir.constant(562949953421310 : i77) : i77
  %1 = llvm.mlir.constant(1 : i77) : i77
  %2 = llvm.and %arg0, %0 : i77
  %3 = llvm.or disjoint %2, %1 : i77
  "llvm.return"(%3) : (i77) -> ()
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


