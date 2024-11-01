import SSA.Projects.InstCombine.tests.proofs.gandhorhand_proof
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
section gandhorhand_statements

def test1_before := [llvm|
{
^0(%arg10 : i32, %arg11 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.and %arg10, %0 : i32
  %3 = llvm.and %arg11, %1 : i32
  %4 = llvm.or %2, %3 : i32
  %5 = llvm.and %4, %0 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg10 : i32, %arg11 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.and %arg10, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
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
^0(%arg8 : i32, %arg9 : i8):
  %0 = llvm.mlir.constant(65536 : i32) : i32
  %1 = llvm.zext %arg9 : i8 to i32
  %2 = llvm.or %arg8, %1 : i32
  %3 = llvm.and %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg8 : i32, %arg9 : i8):
  %0 = llvm.mlir.constant(65536 : i32) : i32
  %1 = llvm.and %arg8, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
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
^0(%arg6 : i32, %arg7 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.shl %arg7, %0 : i32
  %2 = llvm.or %arg6, %1 : i32
  %3 = llvm.and %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test3_after := [llvm|
{
^0(%arg6 : i32, %arg7 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.and %arg6, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
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
^0(%arg4 : i32, %arg5 : i32):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.lshr %arg5, %0 : i32
  %3 = llvm.or %arg4, %2 : i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test4_after := [llvm|
{
^0(%arg4 : i32, %arg5 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.and %arg4, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
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



def or_test1_before := [llvm|
{
^0(%arg2 : i32, %arg3 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.and %arg2, %0 : i32
  %2 = llvm.or %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def or_test1_after := [llvm|
{
^0(%arg2 : i32, %arg3 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_test1_proof : or_test1_before ⊑ or_test1_after := by
  unfold or_test1_before or_test1_after
  simp_alive_peephole
  intros
  ---BEGIN or_test1
  apply or_test1_thm
  ---END or_test1



def or_test2_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.mlir.constant(-128 : i8) : i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = llvm.or %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def or_test2_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  "llvm.return"(%0) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_test2_proof : or_test2_before ⊑ or_test2_after := by
  unfold or_test2_before or_test2_after
  simp_alive_peephole
  intros
  ---BEGIN or_test2
  apply or_test2_thm
  ---END or_test2


