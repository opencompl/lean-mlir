import SSA.Projects.InstCombine.tests.proofs.gshouldhchangehtype_proof
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
section gshouldhchangehtype_statements

def test1_before := [llvm|
{
^0(%arg6 : i8, %arg7 : i8):
  %0 = llvm.zext %arg6 : i8 to i64
  %1 = llvm.zext %arg7 : i8 to i64
  %2 = llvm.add %0, %1 : i64
  %3 = llvm.trunc %2 : i64 to i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg6 : i8, %arg7 : i8):
  %0 = llvm.add %arg6, %arg7 : i8
  "llvm.return"(%0) : (i8) -> ()
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
^0(%arg4 : i16, %arg5 : i16):
  %0 = llvm.zext %arg4 : i16 to i64
  %1 = llvm.zext %arg5 : i16 to i64
  %2 = llvm.add %0, %1 : i64
  %3 = llvm.trunc %2 : i64 to i16
  "llvm.return"(%3) : (i16) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg4 : i16, %arg5 : i16):
  %0 = llvm.add %arg4, %arg5 : i16
  "llvm.return"(%0) : (i16) -> ()
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
^0(%arg2 : i32, %arg3 : i32):
  %0 = llvm.zext %arg2 : i32 to i64
  %1 = llvm.zext %arg3 : i32 to i64
  %2 = llvm.add %0, %1 : i64
  %3 = llvm.trunc %2 : i64 to i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test3_after := [llvm|
{
^0(%arg2 : i32, %arg3 : i32):
  %0 = llvm.add %arg2, %arg3 : i32
  "llvm.return"(%0) : (i32) -> ()
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
^0(%arg0 : i9, %arg1 : i9):
  %0 = llvm.zext %arg0 : i9 to i64
  %1 = llvm.zext %arg1 : i9 to i64
  %2 = llvm.add %0, %1 : i64
  %3 = llvm.trunc %2 : i64 to i9
  "llvm.return"(%3) : (i9) -> ()
}
]
def test4_after := [llvm|
{
^0(%arg0 : i9, %arg1 : i9):
  %0 = llvm.zext %arg0 : i9 to i64
  %1 = llvm.zext %arg1 : i9 to i64
  %2 = llvm.add %0, %1 overflow<nsw,nuw> : i64
  %3 = llvm.trunc %2 : i64 to i9
  "llvm.return"(%3) : (i9) -> ()
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


