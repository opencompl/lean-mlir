import SSA.Projects.InstCombine.tests.proofs.gorhshiftedhmasks_proof
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
section gorhshiftedhmasks_statements

def or_and_shifts1_before := [llvm|
{
^0(%arg14 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.mlir.constant(15 : i32) : i32
  %2 = llvm.mlir.constant(5 : i32) : i32
  %3 = llvm.mlir.constant(60 : i32) : i32
  %4 = llvm.shl %arg14, %0 : i32
  %5 = llvm.and %4, %1 : i32
  %6 = llvm.shl %arg14, %2 : i32
  %7 = llvm.and %6, %3 : i32
  %8 = llvm.or %5, %7 : i32
  "llvm.return"(%8) : (i32) -> ()
}
]
def or_and_shifts1_after := [llvm|
{
^0(%arg14 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.mlir.constant(5 : i32) : i32
  %3 = llvm.mlir.constant(32 : i32) : i32
  %4 = llvm.shl %arg14, %0 : i32
  %5 = llvm.and %4, %1 : i32
  %6 = llvm.shl %arg14, %2 : i32
  %7 = llvm.and %6, %3 : i32
  %8 = llvm.or disjoint %5, %7 : i32
  "llvm.return"(%8) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_and_shifts1_proof : or_and_shifts1_before ⊑ or_and_shifts1_after := by
  unfold or_and_shifts1_before or_and_shifts1_after
  simp_alive_peephole
  intros
  ---BEGIN or_and_shifts1
  apply or_and_shifts1_thm
  ---END or_and_shifts1



def or_and_shifts2_before := [llvm|
{
^0(%arg13 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.mlir.constant(896 : i32) : i32
  %2 = llvm.mlir.constant(4 : i32) : i32
  %3 = llvm.mlir.constant(7 : i32) : i32
  %4 = llvm.shl %arg13, %0 : i32
  %5 = llvm.and %4, %1 : i32
  %6 = llvm.lshr %arg13, %2 : i32
  %7 = llvm.and %6, %3 : i32
  %8 = llvm.or %5, %7 : i32
  "llvm.return"(%8) : (i32) -> ()
}
]
def or_and_shifts2_after := [llvm|
{
^0(%arg13 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.mlir.constant(896 : i32) : i32
  %2 = llvm.mlir.constant(4 : i32) : i32
  %3 = llvm.mlir.constant(7 : i32) : i32
  %4 = llvm.shl %arg13, %0 : i32
  %5 = llvm.and %4, %1 : i32
  %6 = llvm.lshr %arg13, %2 : i32
  %7 = llvm.and %6, %3 : i32
  %8 = llvm.or disjoint %5, %7 : i32
  "llvm.return"(%8) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_and_shifts2_proof : or_and_shifts2_before ⊑ or_and_shifts2_after := by
  unfold or_and_shifts2_before or_and_shifts2_after
  simp_alive_peephole
  intros
  ---BEGIN or_and_shifts2
  apply or_and_shifts2_thm
  ---END or_and_shifts2



def or_and_shift_shift_and_before := [llvm|
{
^0(%arg12 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(3 : i32) : i32
  %2 = llvm.mlir.constant(2 : i32) : i32
  %3 = llvm.mlir.constant(28 : i32) : i32
  %4 = llvm.and %arg12, %0 : i32
  %5 = llvm.shl %4, %1 : i32
  %6 = llvm.shl %arg12, %2 : i32
  %7 = llvm.and %6, %3 : i32
  %8 = llvm.or %5, %7 : i32
  "llvm.return"(%8) : (i32) -> ()
}
]
def or_and_shift_shift_and_after := [llvm|
{
^0(%arg12 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.mlir.constant(56 : i32) : i32
  %2 = llvm.mlir.constant(2 : i32) : i32
  %3 = llvm.mlir.constant(28 : i32) : i32
  %4 = llvm.shl %arg12, %0 : i32
  %5 = llvm.and %4, %1 : i32
  %6 = llvm.shl %arg12, %2 : i32
  %7 = llvm.and %6, %3 : i32
  %8 = llvm.or %5, %7 : i32
  "llvm.return"(%8) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_and_shift_shift_and_proof : or_and_shift_shift_and_before ⊑ or_and_shift_shift_and_after := by
  unfold or_and_shift_shift_and_before or_and_shift_shift_and_after
  simp_alive_peephole
  intros
  ---BEGIN or_and_shift_shift_and
  apply or_and_shift_shift_and_thm
  ---END or_and_shift_shift_and



def multiuse1_before := [llvm|
{
^0(%arg11 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(4 : i32) : i32
  %2 = llvm.mlir.constant(6 : i32) : i32
  %3 = llvm.mlir.constant(1 : i32) : i32
  %4 = llvm.and %arg11, %0 : i32
  %5 = llvm.and %arg11, %1 : i32
  %6 = llvm.shl %4, %2 overflow<nsw,nuw> : i32
  %7 = llvm.lshr exact %4, %3 : i32
  %8 = llvm.shl %5, %2 overflow<nsw,nuw> : i32
  %9 = llvm.lshr exact %5, %3 : i32
  %10 = llvm.or %6, %8 : i32
  %11 = llvm.or %7, %9 : i32
  %12 = llvm.or %11, %10 : i32
  "llvm.return"(%12) : (i32) -> ()
}
]
def multiuse1_after := [llvm|
{
^0(%arg11 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.mlir.constant(6 : i32) : i32
  %3 = llvm.mlir.constant(384 : i32) : i32
  %4 = llvm.lshr %arg11, %0 : i32
  %5 = llvm.and %4, %0 : i32
  %6 = llvm.lshr %arg11, %0 : i32
  %7 = llvm.and %6, %1 : i32
  %8 = llvm.shl %arg11, %2 : i32
  %9 = llvm.and %8, %3 : i32
  %10 = llvm.or disjoint %5, %7 : i32
  %11 = llvm.or disjoint %10, %9 : i32
  "llvm.return"(%11) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem multiuse1_proof : multiuse1_before ⊑ multiuse1_after := by
  unfold multiuse1_before multiuse1_after
  simp_alive_peephole
  intros
  ---BEGIN multiuse1
  apply multiuse1_thm
  ---END multiuse1



def multiuse2_before := [llvm|
{
^0(%arg10 : i32):
  %0 = llvm.mlir.constant(6 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.mlir.constant(24 : i32) : i32
  %4 = llvm.mlir.constant(96 : i32) : i32
  %5 = llvm.and %arg10, %0 : i32
  %6 = llvm.shl %5, %1 overflow<nsw,nuw> : i32
  %7 = llvm.shl %5, %2 overflow<nsw,nuw> : i32
  %8 = llvm.and %arg10, %3 : i32
  %9 = llvm.shl %8, %1 overflow<nsw,nuw> : i32
  %10 = llvm.shl %8, %2 overflow<nsw,nuw> : i32
  %11 = llvm.and %arg10, %4 : i32
  %12 = llvm.shl %11, %1 overflow<nsw,nuw> : i32
  %13 = llvm.shl %11, %2 overflow<nsw,nuw> : i32
  %14 = llvm.or %6, %9 : i32
  %15 = llvm.or %12, %14 : i32
  %16 = llvm.or %13, %10 : i32
  %17 = llvm.or %7, %16 : i32
  %18 = llvm.or %15, %17 : i32
  "llvm.return"(%18) : (i32) -> ()
}
]
def multiuse2_after := [llvm|
{
^0(%arg10 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(12 : i32) : i32
  %2 = llvm.mlir.constant(48 : i32) : i32
  %3 = llvm.mlir.constant(192 : i32) : i32
  %4 = llvm.mlir.constant(8 : i32) : i32
  %5 = llvm.mlir.constant(32256 : i32) : i32
  %6 = llvm.shl %arg10, %0 : i32
  %7 = llvm.and %6, %1 : i32
  %8 = llvm.shl %arg10, %0 : i32
  %9 = llvm.and %8, %2 : i32
  %10 = llvm.shl %arg10, %0 : i32
  %11 = llvm.and %10, %3 : i32
  %12 = llvm.shl %arg10, %4 : i32
  %13 = llvm.and %12, %5 : i32
  %14 = llvm.or disjoint %11, %9 : i32
  %15 = llvm.or disjoint %7, %14 : i32
  %16 = llvm.or disjoint %13, %15 : i32
  "llvm.return"(%16) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem multiuse2_proof : multiuse2_before ⊑ multiuse2_after := by
  unfold multiuse2_before multiuse2_after
  simp_alive_peephole
  intros
  ---BEGIN multiuse2
  apply multiuse2_thm
  ---END multiuse2



def multiuse3_before := [llvm|
{
^0(%arg9 : i32):
  %0 = llvm.mlir.constant(96 : i32) : i32
  %1 = llvm.mlir.constant(6 : i32) : i32
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.mlir.constant(1920 : i32) : i32
  %4 = llvm.mlir.constant(15 : i32) : i32
  %5 = llvm.and %arg9, %0 : i32
  %6 = llvm.shl %5, %1 overflow<nsw,nuw> : i32
  %7 = llvm.lshr exact %5, %2 : i32
  %8 = llvm.shl %arg9, %1 : i32
  %9 = llvm.and %8, %3 : i32
  %10 = llvm.or %6, %9 : i32
  %11 = llvm.lshr %arg9, %2 : i32
  %12 = llvm.and %11, %4 : i32
  %13 = llvm.or %7, %12 : i32
  %14 = llvm.or %13, %10 : i32
  "llvm.return"(%14) : (i32) -> ()
}
]
def multiuse3_after := [llvm|
{
^0(%arg9 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(48 : i32) : i32
  %2 = llvm.mlir.constant(6 : i32) : i32
  %3 = llvm.mlir.constant(8064 : i32) : i32
  %4 = llvm.mlir.constant(15 : i32) : i32
  %5 = llvm.lshr %arg9, %0 : i32
  %6 = llvm.and %5, %1 : i32
  %7 = llvm.shl %arg9, %2 : i32
  %8 = llvm.and %7, %3 : i32
  %9 = llvm.lshr %arg9, %0 : i32
  %10 = llvm.and %9, %4 : i32
  %11 = llvm.or disjoint %6, %10 : i32
  %12 = llvm.or disjoint %11, %8 : i32
  "llvm.return"(%12) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem multiuse3_proof : multiuse3_before ⊑ multiuse3_after := by
  unfold multiuse3_before multiuse3_after
  simp_alive_peephole
  intros
  ---BEGIN multiuse3
  apply multiuse3_thm
  ---END multiuse3



def shl_mask_before := [llvm|
{
^0(%arg6 : i32):
  %0 = llvm.mlir.constant(255 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.and %arg6, %0 : i32
  %3 = llvm.shl %2, %1 : i32
  %4 = llvm.or %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def shl_mask_after := [llvm|
{
^0(%arg6 : i32):
  %0 = llvm.mlir.constant(255 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.and %arg6, %0 : i32
  %3 = llvm.shl %2, %1 overflow<nsw,nuw> : i32
  %4 = llvm.or disjoint %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_mask_proof : shl_mask_before ⊑ shl_mask_after := by
  unfold shl_mask_before shl_mask_after
  simp_alive_peephole
  intros
  ---BEGIN shl_mask
  apply shl_mask_thm
  ---END shl_mask



def shl_mask_wrong_shl_const_before := [llvm|
{
^0(%arg5 : i32):
  %0 = llvm.mlir.constant(255 : i32) : i32
  %1 = llvm.mlir.constant(7 : i32) : i32
  %2 = llvm.and %arg5, %0 : i32
  %3 = llvm.shl %2, %1 : i32
  %4 = llvm.or %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def shl_mask_wrong_shl_const_after := [llvm|
{
^0(%arg5 : i32):
  %0 = llvm.mlir.constant(255 : i32) : i32
  %1 = llvm.mlir.constant(7 : i32) : i32
  %2 = llvm.and %arg5, %0 : i32
  %3 = llvm.shl %2, %1 overflow<nsw,nuw> : i32
  %4 = llvm.or %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_mask_wrong_shl_const_proof : shl_mask_wrong_shl_const_before ⊑ shl_mask_wrong_shl_const_after := by
  unfold shl_mask_wrong_shl_const_before shl_mask_wrong_shl_const_after
  simp_alive_peephole
  intros
  ---BEGIN shl_mask_wrong_shl_const
  apply shl_mask_wrong_shl_const_thm
  ---END shl_mask_wrong_shl_const



def shl_mask_weird_type_before := [llvm|
{
^0(%arg4 : i37):
  %0 = llvm.mlir.constant(255 : i37) : i37
  %1 = llvm.mlir.constant(8 : i37) : i37
  %2 = llvm.and %arg4, %0 : i37
  %3 = llvm.shl %2, %1 : i37
  %4 = llvm.or %2, %3 : i37
  "llvm.return"(%4) : (i37) -> ()
}
]
def shl_mask_weird_type_after := [llvm|
{
^0(%arg4 : i37):
  %0 = llvm.mlir.constant(255 : i37) : i37
  %1 = llvm.mlir.constant(8 : i37) : i37
  %2 = llvm.and %arg4, %0 : i37
  %3 = llvm.shl %2, %1 overflow<nsw,nuw> : i37
  %4 = llvm.or disjoint %2, %3 : i37
  "llvm.return"(%4) : (i37) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_mask_weird_type_proof : shl_mask_weird_type_before ⊑ shl_mask_weird_type_after := by
  unfold shl_mask_weird_type_before shl_mask_weird_type_after
  simp_alive_peephole
  intros
  ---BEGIN shl_mask_weird_type
  apply shl_mask_weird_type_thm
  ---END shl_mask_weird_type



def shl_mul_mask_before := [llvm|
{
^0(%arg1 : i32):
  %0 = llvm.mlir.constant(255 : i32) : i32
  %1 = llvm.mlir.constant(65537 : i32) : i32
  %2 = llvm.mlir.constant(8 : i32) : i32
  %3 = llvm.and %arg1, %0 : i32
  %4 = llvm.mul %3, %1 : i32
  %5 = llvm.shl %3, %2 : i32
  %6 = llvm.or %4, %5 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def shl_mul_mask_after := [llvm|
{
^0(%arg1 : i32):
  %0 = llvm.mlir.constant(255 : i32) : i32
  %1 = llvm.mlir.constant(65537 : i32) : i32
  %2 = llvm.mlir.constant(8 : i32) : i32
  %3 = llvm.and %arg1, %0 : i32
  %4 = llvm.mul %3, %1 overflow<nsw,nuw> : i32
  %5 = llvm.shl %3, %2 overflow<nsw,nuw> : i32
  %6 = llvm.or %4, %5 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_mul_mask_proof : shl_mul_mask_before ⊑ shl_mul_mask_after := by
  unfold shl_mul_mask_before shl_mul_mask_after
  simp_alive_peephole
  intros
  ---BEGIN shl_mul_mask
  apply shl_mul_mask_thm
  ---END shl_mul_mask



def shl_mul_mask_wrong_mul_const_before := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(255 : i32) : i32
  %1 = llvm.mlir.constant(65535 : i32) : i32
  %2 = llvm.mlir.constant(8 : i32) : i32
  %3 = llvm.and %arg0, %0 : i32
  %4 = llvm.mul %3, %1 : i32
  %5 = llvm.shl %3, %2 : i32
  %6 = llvm.or %4, %5 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def shl_mul_mask_wrong_mul_const_after := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(255 : i32) : i32
  %1 = llvm.mlir.constant(65535 : i32) : i32
  %2 = llvm.mlir.constant(8 : i32) : i32
  %3 = llvm.and %arg0, %0 : i32
  %4 = llvm.mul %3, %1 overflow<nsw,nuw> : i32
  %5 = llvm.shl %3, %2 overflow<nsw,nuw> : i32
  %6 = llvm.or %4, %5 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_mul_mask_wrong_mul_const_proof : shl_mul_mask_wrong_mul_const_before ⊑ shl_mul_mask_wrong_mul_const_after := by
  unfold shl_mul_mask_wrong_mul_const_before shl_mul_mask_wrong_mul_const_after
  simp_alive_peephole
  intros
  ---BEGIN shl_mul_mask_wrong_mul_const
  apply shl_mul_mask_wrong_mul_const_thm
  ---END shl_mul_mask_wrong_mul_const


