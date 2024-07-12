import SSA.Projects.InstCombine.lean.gorhshiftedhmasks_proof
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
                                                                       
def or_and_shifts1_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 15 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
  %3 = "llvm.mlir.constant"() <{value = 60 : i32}> : () -> i32
  %4 = llvm.shl %arg0, %0 : i32
  %5 = llvm.and %4, %1 : i32
  %6 = llvm.shl %arg0, %2 : i32
  %7 = llvm.and %6, %3 : i32
  %8 = llvm.or %5, %7 : i32
  "llvm.return"(%8) : (i32) -> ()
}
]
def or_and_shifts1_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
  %3 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
  %4 = llvm.shl %arg0, %0 : i32
  %5 = llvm.and %4, %1 : i32
  %6 = llvm.shl %arg0, %2 : i32
  %7 = llvm.and %6, %3 : i32
  %8 = llvm.or %5, %7 : i32
  "llvm.return"(%8) : (i32) -> ()
}
]
theorem or_and_shifts1_proof : or_and_shifts1_before ⊑ or_and_shifts1_after := by
  unfold or_and_shifts1_before or_and_shifts1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_and_shifts1
  apply or_and_shifts1_thm
  ---END or_and_shifts1



def or_and_shift_shift_and_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 7 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %3 = "llvm.mlir.constant"() <{value = 28 : i32}> : () -> i32
  %4 = llvm.and %arg0, %0 : i32
  %5 = llvm.shl %4, %1 : i32
  %6 = llvm.shl %arg0, %2 : i32
  %7 = llvm.and %6, %3 : i32
  %8 = llvm.or %5, %7 : i32
  "llvm.return"(%8) : (i32) -> ()
}
]
def or_and_shift_shift_and_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 56 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %3 = "llvm.mlir.constant"() <{value = 28 : i32}> : () -> i32
  %4 = llvm.shl %arg0, %0 : i32
  %5 = llvm.and %4, %1 : i32
  %6 = llvm.shl %arg0, %2 : i32
  %7 = llvm.and %6, %3 : i32
  %8 = llvm.or %5, %7 : i32
  "llvm.return"(%8) : (i32) -> ()
}
]
theorem or_and_shift_shift_and_proof : or_and_shift_shift_and_before ⊑ or_and_shift_shift_and_after := by
  unfold or_and_shift_shift_and_before or_and_shift_shift_and_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_and_shift_shift_and
  apply or_and_shift_shift_and_thm
  ---END or_and_shift_shift_and



def multiuse1_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = 6 : i32}> : () -> i32
  %3 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %4 = llvm.and %arg0, %0 : i32
  %5 = llvm.and %arg0, %1 : i32
  %6 = llvm.shl %4, %2 : i32
  %7 = llvm.lshr %4, %3 : i32
  %8 = llvm.shl %5, %2 : i32
  %9 = llvm.lshr %5, %3 : i32
  %10 = llvm.or %6, %8 : i32
  %11 = llvm.or %7, %9 : i32
  %12 = llvm.or %11, %10 : i32
  "llvm.return"(%12) : (i32) -> ()
}
]
def multiuse1_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = 6 : i32}> : () -> i32
  %3 = "llvm.mlir.constant"() <{value = 384 : i32}> : () -> i32
  %4 = llvm.lshr %arg0, %0 : i32
  %5 = llvm.and %4, %0 : i32
  %6 = llvm.lshr %arg0, %0 : i32
  %7 = llvm.and %6, %1 : i32
  %8 = llvm.shl %arg0, %2 : i32
  %9 = llvm.and %8, %3 : i32
  %10 = llvm.or %5, %7 : i32
  %11 = llvm.or %10, %9 : i32
  "llvm.return"(%11) : (i32) -> ()
}
]
theorem multiuse1_proof : multiuse1_before ⊑ multiuse1_after := by
  unfold multiuse1_before multiuse1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN multiuse1
  apply multiuse1_thm
  ---END multiuse1



def multiuse2_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 6 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %3 = "llvm.mlir.constant"() <{value = 24 : i32}> : () -> i32
  %4 = "llvm.mlir.constant"() <{value = 96 : i32}> : () -> i32
  %5 = llvm.and %arg0, %0 : i32
  %6 = llvm.shl %5, %1 : i32
  %7 = llvm.shl %5, %2 : i32
  %8 = llvm.and %arg0, %3 : i32
  %9 = llvm.shl %8, %1 : i32
  %10 = llvm.shl %8, %2 : i32
  %11 = llvm.and %arg0, %4 : i32
  %12 = llvm.shl %11, %1 : i32
  %13 = llvm.shl %11, %2 : i32
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
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 12 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = 48 : i32}> : () -> i32
  %3 = "llvm.mlir.constant"() <{value = 192 : i32}> : () -> i32
  %4 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %5 = "llvm.mlir.constant"() <{value = 32256 : i32}> : () -> i32
  %6 = llvm.shl %arg0, %0 : i32
  %7 = llvm.and %6, %1 : i32
  %8 = llvm.shl %arg0, %0 : i32
  %9 = llvm.and %8, %2 : i32
  %10 = llvm.shl %arg0, %0 : i32
  %11 = llvm.and %10, %3 : i32
  %12 = llvm.shl %arg0, %4 : i32
  %13 = llvm.and %12, %5 : i32
  %14 = llvm.or %11, %9 : i32
  %15 = llvm.or %7, %14 : i32
  %16 = llvm.or %13, %15 : i32
  "llvm.return"(%16) : (i32) -> ()
}
]
theorem multiuse2_proof : multiuse2_before ⊑ multiuse2_after := by
  unfold multiuse2_before multiuse2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN multiuse2
  apply multiuse2_thm
  ---END multiuse2



def multiuse3_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 96 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 6 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %3 = "llvm.mlir.constant"() <{value = 1920 : i32}> : () -> i32
  %4 = "llvm.mlir.constant"() <{value = 15 : i32}> : () -> i32
  %5 = llvm.and %arg0, %0 : i32
  %6 = llvm.shl %5, %1 : i32
  %7 = llvm.lshr %5, %2 : i32
  %8 = llvm.shl %arg0, %1 : i32
  %9 = llvm.and %8, %3 : i32
  %10 = llvm.or %6, %9 : i32
  %11 = llvm.lshr %arg0, %2 : i32
  %12 = llvm.and %11, %4 : i32
  %13 = llvm.or %7, %12 : i32
  %14 = llvm.or %13, %10 : i32
  "llvm.return"(%14) : (i32) -> ()
}
]
def multiuse3_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 48 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = 6 : i32}> : () -> i32
  %3 = "llvm.mlir.constant"() <{value = 8064 : i32}> : () -> i32
  %4 = "llvm.mlir.constant"() <{value = 15 : i32}> : () -> i32
  %5 = llvm.lshr %arg0, %0 : i32
  %6 = llvm.and %5, %1 : i32
  %7 = llvm.shl %arg0, %2 : i32
  %8 = llvm.and %7, %3 : i32
  %9 = llvm.lshr %arg0, %0 : i32
  %10 = llvm.and %9, %4 : i32
  %11 = llvm.or %6, %10 : i32
  %12 = llvm.or %11, %8 : i32
  "llvm.return"(%12) : (i32) -> ()
}
]
theorem multiuse3_proof : multiuse3_before ⊑ multiuse3_after := by
  unfold multiuse3_before multiuse3_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN multiuse3
  apply multiuse3_thm
  ---END multiuse3


