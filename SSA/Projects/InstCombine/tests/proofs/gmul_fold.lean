import SSA.Projects.InstCombine.tests.proofs.gmul_fold_proof
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
section gmul_fold_statements

def mul8_low_A0_B0_before := [llvm|
{
^0(%arg60 : i8, %arg61 : i8):
  %0 = llvm.mlir.constant(15 : i8) : i8
  %1 = llvm.mlir.constant(4 : i8) : i8
  %2 = llvm.and %arg60, %0 : i8
  %3 = llvm.lshr %arg60, %1 : i8
  %4 = llvm.and %arg61, %0 : i8
  %5 = llvm.lshr %arg61, %1 : i8
  %6 = llvm.mul %5, %arg60 : i8
  %7 = llvm.mul %3, %arg61 : i8
  %8 = llvm.mul %4, %2 : i8
  %9 = llvm.add %6, %7 : i8
  %10 = llvm.shl %9, %1 : i8
  %11 = llvm.add %10, %8 : i8
  "llvm.return"(%11) : (i8) -> ()
}
]
def mul8_low_A0_B0_after := [llvm|
{
^0(%arg60 : i8, %arg61 : i8):
  %0 = llvm.mul %arg60, %arg61 : i8
  "llvm.return"(%0) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul8_low_A0_B0_proof : mul8_low_A0_B0_before ⊑ mul8_low_A0_B0_after := by
  unfold mul8_low_A0_B0_before mul8_low_A0_B0_after
  simp_alive_peephole
  intros
  ---BEGIN mul8_low_A0_B0
  apply mul8_low_A0_B0_thm
  ---END mul8_low_A0_B0



def mul8_low_before := [llvm|
{
^0(%arg26 : i8, %arg27 : i8):
  %0 = llvm.mlir.constant(15 : i8) : i8
  %1 = llvm.mlir.constant(4 : i8) : i8
  %2 = llvm.and %arg26, %0 : i8
  %3 = llvm.lshr %arg26, %1 : i8
  %4 = llvm.and %arg27, %0 : i8
  %5 = llvm.lshr %arg27, %1 : i8
  %6 = llvm.mul %5, %2 : i8
  %7 = llvm.mul %4, %3 : i8
  %8 = llvm.mul %4, %2 : i8
  %9 = llvm.add %6, %7 : i8
  %10 = llvm.shl %9, %1 : i8
  %11 = llvm.add %10, %8 : i8
  "llvm.return"(%11) : (i8) -> ()
}
]
def mul8_low_after := [llvm|
{
^0(%arg26 : i8, %arg27 : i8):
  %0 = llvm.mul %arg26, %arg27 : i8
  "llvm.return"(%0) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul8_low_proof : mul8_low_before ⊑ mul8_low_after := by
  unfold mul8_low_before mul8_low_after
  simp_alive_peephole
  intros
  ---BEGIN mul8_low
  apply mul8_low_thm
  ---END mul8_low



def mul16_low_before := [llvm|
{
^0(%arg24 : i16, %arg25 : i16):
  %0 = llvm.mlir.constant(255 : i16) : i16
  %1 = llvm.mlir.constant(8 : i16) : i16
  %2 = llvm.and %arg24, %0 : i16
  %3 = llvm.lshr %arg24, %1 : i16
  %4 = llvm.and %arg25, %0 : i16
  %5 = llvm.lshr %arg25, %1 : i16
  %6 = llvm.mul %5, %2 : i16
  %7 = llvm.mul %4, %3 : i16
  %8 = llvm.mul %4, %2 : i16
  %9 = llvm.add %6, %7 : i16
  %10 = llvm.shl %9, %1 : i16
  %11 = llvm.add %10, %8 : i16
  "llvm.return"(%11) : (i16) -> ()
}
]
def mul16_low_after := [llvm|
{
^0(%arg24 : i16, %arg25 : i16):
  %0 = llvm.mul %arg24, %arg25 : i16
  "llvm.return"(%0) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul16_low_proof : mul16_low_before ⊑ mul16_low_after := by
  unfold mul16_low_before mul16_low_after
  simp_alive_peephole
  intros
  ---BEGIN mul16_low
  apply mul16_low_thm
  ---END mul16_low



def mul32_low_before := [llvm|
{
^0(%arg22 : i32, %arg23 : i32):
  %0 = llvm.mlir.constant(65535 : i32) : i32
  %1 = llvm.mlir.constant(16 : i32) : i32
  %2 = llvm.and %arg22, %0 : i32
  %3 = llvm.lshr %arg22, %1 : i32
  %4 = llvm.and %arg23, %0 : i32
  %5 = llvm.lshr %arg23, %1 : i32
  %6 = llvm.mul %5, %2 : i32
  %7 = llvm.mul %4, %3 : i32
  %8 = llvm.mul %4, %2 : i32
  %9 = llvm.add %6, %7 : i32
  %10 = llvm.shl %9, %1 : i32
  %11 = llvm.add %10, %8 : i32
  "llvm.return"(%11) : (i32) -> ()
}
]
def mul32_low_after := [llvm|
{
^0(%arg22 : i32, %arg23 : i32):
  %0 = llvm.mul %arg22, %arg23 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul32_low_proof : mul32_low_before ⊑ mul32_low_after := by
  unfold mul32_low_before mul32_low_after
  simp_alive_peephole
  intros
  ---BEGIN mul32_low
  apply mul32_low_thm
  ---END mul32_low



def mul64_low_before := [llvm|
{
^0(%arg20 : i64, %arg21 : i64):
  %0 = llvm.mlir.constant(4294967295) : i64
  %1 = llvm.mlir.constant(32) : i64
  %2 = llvm.and %arg20, %0 : i64
  %3 = llvm.lshr %arg20, %1 : i64
  %4 = llvm.and %arg21, %0 : i64
  %5 = llvm.lshr %arg21, %1 : i64
  %6 = llvm.mul %5, %2 : i64
  %7 = llvm.mul %4, %3 : i64
  %8 = llvm.mul %4, %2 : i64
  %9 = llvm.add %6, %7 : i64
  %10 = llvm.shl %9, %1 : i64
  %11 = llvm.add %10, %8 : i64
  "llvm.return"(%11) : (i64) -> ()
}
]
def mul64_low_after := [llvm|
{
^0(%arg20 : i64, %arg21 : i64):
  %0 = llvm.mul %arg20, %arg21 : i64
  "llvm.return"(%0) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul64_low_proof : mul64_low_before ⊑ mul64_low_after := by
  unfold mul64_low_before mul64_low_after
  simp_alive_peephole
  intros
  ---BEGIN mul64_low
  apply mul64_low_thm
  ---END mul64_low



def mul128_low_before := [llvm|
{
^0(%arg18 : i128, %arg19 : i128):
  %0 = llvm.mlir.constant(18446744073709551615 : i128) : i128
  %1 = llvm.mlir.constant(64 : i128) : i128
  %2 = llvm.and %arg18, %0 : i128
  %3 = llvm.lshr %arg18, %1 : i128
  %4 = llvm.and %arg19, %0 : i128
  %5 = llvm.lshr %arg19, %1 : i128
  %6 = llvm.mul %5, %2 : i128
  %7 = llvm.mul %4, %3 : i128
  %8 = llvm.mul %4, %2 : i128
  %9 = llvm.add %6, %7 : i128
  %10 = llvm.shl %9, %1 : i128
  %11 = llvm.add %10, %8 : i128
  "llvm.return"(%11) : (i128) -> ()
}
]
def mul128_low_after := [llvm|
{
^0(%arg18 : i128, %arg19 : i128):
  %0 = llvm.mul %arg18, %arg19 : i128
  "llvm.return"(%0) : (i128) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul128_low_proof : mul128_low_before ⊑ mul128_low_after := by
  unfold mul128_low_before mul128_low_after
  simp_alive_peephole
  intros
  ---BEGIN mul128_low
  apply mul128_low_thm
  ---END mul128_low



def mul130_low_before := [llvm|
{
^0(%arg12 : i130, %arg13 : i130):
  %0 = llvm.mlir.constant(36893488147419103231 : i130) : i130
  %1 = llvm.mlir.constant(65 : i130) : i130
  %2 = llvm.and %arg12, %0 : i130
  %3 = llvm.lshr %arg12, %1 : i130
  %4 = llvm.and %arg13, %0 : i130
  %5 = llvm.lshr %arg13, %1 : i130
  %6 = llvm.mul %5, %2 : i130
  %7 = llvm.mul %4, %3 : i130
  %8 = llvm.mul %4, %2 : i130
  %9 = llvm.add %6, %7 : i130
  %10 = llvm.shl %9, %1 : i130
  %11 = llvm.add %10, %8 : i130
  "llvm.return"(%11) : (i130) -> ()
}
]
def mul130_low_after := [llvm|
{
^0(%arg12 : i130, %arg13 : i130):
  %0 = llvm.mul %arg12, %arg13 : i130
  "llvm.return"(%0) : (i130) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul130_low_proof : mul130_low_before ⊑ mul130_low_after := by
  unfold mul130_low_before mul130_low_after
  simp_alive_peephole
  intros
  ---BEGIN mul130_low
  apply mul130_low_thm
  ---END mul130_low



def mul9_low_before := [llvm|
{
^0(%arg8 : i9, %arg9 : i9):
  %0 = llvm.mlir.constant(15 : i9) : i9
  %1 = llvm.mlir.constant(4 : i9) : i9
  %2 = llvm.and %arg8, %0 : i9
  %3 = llvm.lshr %arg8, %1 : i9
  %4 = llvm.and %arg9, %0 : i9
  %5 = llvm.lshr %arg9, %1 : i9
  %6 = llvm.mul %5, %2 : i9
  %7 = llvm.mul %4, %3 : i9
  %8 = llvm.mul %4, %2 : i9
  %9 = llvm.add %6, %7 : i9
  %10 = llvm.shl %9, %1 : i9
  %11 = llvm.add %10, %8 : i9
  "llvm.return"(%11) : (i9) -> ()
}
]
def mul9_low_after := [llvm|
{
^0(%arg8 : i9, %arg9 : i9):
  %0 = llvm.mlir.constant(15 : i9) : i9
  %1 = llvm.mlir.constant(4 : i9) : i9
  %2 = llvm.and %arg8, %0 : i9
  %3 = llvm.lshr %arg8, %1 : i9
  %4 = llvm.and %arg9, %0 : i9
  %5 = llvm.lshr %arg9, %1 : i9
  %6 = llvm.mul %5, %2 overflow<nuw> : i9
  %7 = llvm.mul %4, %3 overflow<nuw> : i9
  %8 = llvm.mul %4, %2 overflow<nsw,nuw> : i9
  %9 = llvm.add %6, %7 : i9
  %10 = llvm.shl %9, %1 : i9
  %11 = llvm.add %10, %8 : i9
  "llvm.return"(%11) : (i9) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul9_low_proof : mul9_low_before ⊑ mul9_low_after := by
  unfold mul9_low_before mul9_low_after
  simp_alive_peephole
  intros
  ---BEGIN mul9_low
  apply mul9_low_thm
  ---END mul9_low



def mul16_low_miss_shift_amount_before := [llvm|
{
^0(%arg4 : i16, %arg5 : i16):
  %0 = llvm.mlir.constant(127 : i16) : i16
  %1 = llvm.mlir.constant(8 : i16) : i16
  %2 = llvm.and %arg4, %0 : i16
  %3 = llvm.lshr %arg4, %1 : i16
  %4 = llvm.and %arg5, %0 : i16
  %5 = llvm.lshr %arg5, %1 : i16
  %6 = llvm.mul %5, %2 : i16
  %7 = llvm.mul %4, %3 : i16
  %8 = llvm.mul %4, %2 : i16
  %9 = llvm.add %6, %7 : i16
  %10 = llvm.shl %9, %1 : i16
  %11 = llvm.add %10, %8 : i16
  "llvm.return"(%11) : (i16) -> ()
}
]
def mul16_low_miss_shift_amount_after := [llvm|
{
^0(%arg4 : i16, %arg5 : i16):
  %0 = llvm.mlir.constant(127 : i16) : i16
  %1 = llvm.mlir.constant(8 : i16) : i16
  %2 = llvm.and %arg4, %0 : i16
  %3 = llvm.lshr %arg4, %1 : i16
  %4 = llvm.and %arg5, %0 : i16
  %5 = llvm.lshr %arg5, %1 : i16
  %6 = llvm.mul %5, %2 overflow<nsw,nuw> : i16
  %7 = llvm.mul %4, %3 overflow<nsw,nuw> : i16
  %8 = llvm.mul %4, %2 overflow<nsw,nuw> : i16
  %9 = llvm.add %6, %7 overflow<nuw> : i16
  %10 = llvm.shl %9, %1 : i16
  %11 = llvm.add %10, %8 : i16
  "llvm.return"(%11) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul16_low_miss_shift_amount_proof : mul16_low_miss_shift_amount_before ⊑ mul16_low_miss_shift_amount_after := by
  unfold mul16_low_miss_shift_amount_before mul16_low_miss_shift_amount_after
  simp_alive_peephole
  intros
  ---BEGIN mul16_low_miss_shift_amount
  apply mul16_low_miss_shift_amount_thm
  ---END mul16_low_miss_shift_amount



def mul8_low_miss_half_width_before := [llvm|
{
^0(%arg2 : i8, %arg3 : i8):
  %0 = llvm.mlir.constant(15 : i8) : i8
  %1 = llvm.mlir.constant(3 : i8) : i8
  %2 = llvm.and %arg2, %0 : i8
  %3 = llvm.lshr %arg2, %1 : i8
  %4 = llvm.and %arg3, %0 : i8
  %5 = llvm.lshr %arg3, %1 : i8
  %6 = llvm.mul %5, %2 : i8
  %7 = llvm.mul %4, %3 : i8
  %8 = llvm.mul %4, %2 : i8
  %9 = llvm.add %6, %7 : i8
  %10 = llvm.shl %9, %1 : i8
  %11 = llvm.add %10, %8 : i8
  "llvm.return"(%11) : (i8) -> ()
}
]
def mul8_low_miss_half_width_after := [llvm|
{
^0(%arg2 : i8, %arg3 : i8):
  %0 = llvm.mlir.constant(15 : i8) : i8
  %1 = llvm.mlir.constant(3 : i8) : i8
  %2 = llvm.and %arg2, %0 : i8
  %3 = llvm.lshr %arg2, %1 : i8
  %4 = llvm.and %arg3, %0 : i8
  %5 = llvm.lshr %arg3, %1 : i8
  %6 = llvm.mul %5, %2 : i8
  %7 = llvm.mul %4, %3 : i8
  %8 = llvm.mul %4, %2 overflow<nuw> : i8
  %9 = llvm.add %6, %7 : i8
  %10 = llvm.shl %9, %1 : i8
  %11 = llvm.add %10, %8 : i8
  "llvm.return"(%11) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul8_low_miss_half_width_proof : mul8_low_miss_half_width_before ⊑ mul8_low_miss_half_width_after := by
  unfold mul8_low_miss_half_width_before mul8_low_miss_half_width_after
  simp_alive_peephole
  intros
  ---BEGIN mul8_low_miss_half_width
  apply mul8_low_miss_half_width_thm
  ---END mul8_low_miss_half_width


