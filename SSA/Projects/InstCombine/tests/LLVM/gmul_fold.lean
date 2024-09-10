import SSA.Projects.InstCombine.tests.LLVM.gmul_fold_proof
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
  %0 = "llvm.mlir.constant"() <{value = 15 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 4 : i8}> : () -> i8
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
theorem mul8_low_A0_B0_proof : mul8_low_A0_B0_before ⊑ mul8_low_A0_B0_after := by
  unfold mul8_low_A0_B0_before mul8_low_A0_B0_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN mul8_low_A0_B0
  apply mul8_low_A0_B0_thm
  ---END mul8_low_A0_B0



def mul8_low_before := [llvm|
{
^0(%arg26 : i8, %arg27 : i8):
  %0 = "llvm.mlir.constant"() <{value = 15 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 4 : i8}> : () -> i8
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
theorem mul8_low_proof : mul8_low_before ⊑ mul8_low_after := by
  unfold mul8_low_before mul8_low_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN mul8_low
  apply mul8_low_thm
  ---END mul8_low



def mul16_low_before := [llvm|
{
^0(%arg24 : i16, %arg25 : i16):
  %0 = "llvm.mlir.constant"() <{value = 255 : i16}> : () -> i16
  %1 = "llvm.mlir.constant"() <{value = 8 : i16}> : () -> i16
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
theorem mul16_low_proof : mul16_low_before ⊑ mul16_low_after := by
  unfold mul16_low_before mul16_low_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN mul16_low
  apply mul16_low_thm
  ---END mul16_low



def mul32_low_before := [llvm|
{
^0(%arg22 : i32, %arg23 : i32):
  %0 = "llvm.mlir.constant"() <{value = 65535 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
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
theorem mul32_low_proof : mul32_low_before ⊑ mul32_low_after := by
  unfold mul32_low_before mul32_low_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN mul32_low
  all_goals (try extract_goal ; sorry)
  ---END mul32_low



def mul64_low_before := [llvm|
{
^0(%arg20 : i64, %arg21 : i64):
  %0 = "llvm.mlir.constant"() <{value = 4294967295 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 32 : i64}> : () -> i64
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
theorem mul64_low_proof : mul64_low_before ⊑ mul64_low_after := by
  unfold mul64_low_before mul64_low_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN mul64_low
  all_goals (try extract_goal ; sorry)
  ---END mul64_low



def mul128_low_before := [llvm|
{
^0(%arg18 : i128, %arg19 : i128):
  %0 = "llvm.mlir.constant"() <{value = 18446744073709551615 : i128}> : () -> i128
  %1 = "llvm.mlir.constant"() <{value = 64 : i128}> : () -> i128
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
theorem mul128_low_proof : mul128_low_before ⊑ mul128_low_after := by
  unfold mul128_low_before mul128_low_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN mul128_low
  all_goals (try extract_goal ; sorry)
  ---END mul128_low



def mul130_low_before := [llvm|
{
^0(%arg12 : i130, %arg13 : i130):
  %0 = "llvm.mlir.constant"() <{value = 36893488147419103231 : i130}> : () -> i130
  %1 = "llvm.mlir.constant"() <{value = 65 : i130}> : () -> i130
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
theorem mul130_low_proof : mul130_low_before ⊑ mul130_low_after := by
  unfold mul130_low_before mul130_low_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN mul130_low
  all_goals (try extract_goal ; sorry)
  ---END mul130_low



def mul64_low_no_and_before := [llvm|
{
^0(%arg6 : i64, %arg7 : i64):
  %0 = "llvm.mlir.constant"() <{value = 32 : i64}> : () -> i64
  %1 = llvm.lshr %arg6, %0 : i64
  %2 = llvm.lshr %arg7, %0 : i64
  %3 = llvm.mul %2, %arg6 : i64
  %4 = llvm.mul %arg7, %1 : i64
  %5 = llvm.mul %arg7, %arg6 : i64
  %6 = llvm.add %3, %4 : i64
  %7 = llvm.shl %6, %0 : i64
  %8 = llvm.add %7, %5 : i64
  "llvm.return"(%8) : (i64) -> ()
}
]
def mul64_low_no_and_after := [llvm|
{
^0(%arg6 : i64, %arg7 : i64):
  %0 = "llvm.mlir.constant"() <{value = 32 : i64}> : () -> i64
  %1 = llvm.lshr %arg6, %0 : i64
  %2 = llvm.lshr %arg7, %0 : i64
  %3 = llvm.mul %2, %arg6 : i64
  %4 = llvm.mul %1, %arg7 : i64
  %5 = llvm.mul %arg7, %arg6 : i64
  %6 = llvm.add %3, %4 : i64
  %7 = llvm.shl %6, %0 : i64
  %8 = llvm.add %7, %5 : i64
  "llvm.return"(%8) : (i64) -> ()
}
]
theorem mul64_low_no_and_proof : mul64_low_no_and_before ⊑ mul64_low_no_and_after := by
  unfold mul64_low_no_and_before mul64_low_no_and_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN mul64_low_no_and
  all_goals (try extract_goal ; sorry)
  ---END mul64_low_no_and


