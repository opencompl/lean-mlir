
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
section gorhxorhxor_statements

def or_xor_xor_normal_variant1_before := [llvm|
{
^0(%arg17 : i1, %arg18 : i1):
  %0 = llvm.and %arg17, %arg18 : i1
  %1 = llvm.xor %0, %arg17 : i1
  %2 = llvm.xor %0, %arg18 : i1
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def or_xor_xor_normal_variant1_after := [llvm|
{
^0(%arg17 : i1, %arg18 : i1):
  %0 = llvm.xor %arg17, %arg18 : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_xor_xor_normal_variant1_proof : or_xor_xor_normal_variant1_before ⊑ or_xor_xor_normal_variant1_after := by
  unfold or_xor_xor_normal_variant1_before or_xor_xor_normal_variant1_after
  simp_alive_peephole
  intros
  ---BEGIN or_xor_xor_normal_variant1
  all_goals (try extract_goal ; sorry)
  ---END or_xor_xor_normal_variant1



def or_xor_xor_normal_variant2_before := [llvm|
{
^0(%arg15 : i8, %arg16 : i8):
  %0 = llvm.and %arg15, %arg16 : i8
  %1 = llvm.xor %0, %arg16 : i8
  %2 = llvm.xor %arg15, %0 : i8
  %3 = llvm.or %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def or_xor_xor_normal_variant2_after := [llvm|
{
^0(%arg15 : i8, %arg16 : i8):
  %0 = llvm.xor %arg15, %arg16 : i8
  "llvm.return"(%0) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_xor_xor_normal_variant2_proof : or_xor_xor_normal_variant2_before ⊑ or_xor_xor_normal_variant2_after := by
  unfold or_xor_xor_normal_variant2_before or_xor_xor_normal_variant2_after
  simp_alive_peephole
  intros
  ---BEGIN or_xor_xor_normal_variant2
  all_goals (try extract_goal ; sorry)
  ---END or_xor_xor_normal_variant2



def or_xor_xor_normal_variant3_before := [llvm|
{
^0(%arg13 : i16, %arg14 : i16):
  %0 = llvm.and %arg14, %arg13 : i16
  %1 = llvm.xor %arg14, %0 : i16
  %2 = llvm.xor %arg13, %0 : i16
  %3 = llvm.or %1, %2 : i16
  "llvm.return"(%3) : (i16) -> ()
}
]
def or_xor_xor_normal_variant3_after := [llvm|
{
^0(%arg13 : i16, %arg14 : i16):
  %0 = llvm.xor %arg14, %arg13 : i16
  "llvm.return"(%0) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_xor_xor_normal_variant3_proof : or_xor_xor_normal_variant3_before ⊑ or_xor_xor_normal_variant3_after := by
  unfold or_xor_xor_normal_variant3_before or_xor_xor_normal_variant3_after
  simp_alive_peephole
  intros
  ---BEGIN or_xor_xor_normal_variant3
  all_goals (try extract_goal ; sorry)
  ---END or_xor_xor_normal_variant3



def or_xor_xor_normal_variant4_before := [llvm|
{
^0(%arg11 : i64, %arg12 : i64):
  %0 = llvm.and %arg12, %arg11 : i64
  %1 = llvm.xor %0, %arg12 : i64
  %2 = llvm.xor %0, %arg11 : i64
  %3 = llvm.or %1, %2 : i64
  "llvm.return"(%3) : (i64) -> ()
}
]
def or_xor_xor_normal_variant4_after := [llvm|
{
^0(%arg11 : i64, %arg12 : i64):
  %0 = llvm.xor %arg12, %arg11 : i64
  "llvm.return"(%0) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_xor_xor_normal_variant4_proof : or_xor_xor_normal_variant4_before ⊑ or_xor_xor_normal_variant4_after := by
  unfold or_xor_xor_normal_variant4_before or_xor_xor_normal_variant4_after
  simp_alive_peephole
  intros
  ---BEGIN or_xor_xor_normal_variant4
  all_goals (try extract_goal ; sorry)
  ---END or_xor_xor_normal_variant4



def or_xor_xor_normal_binops_before := [llvm|
{
^0(%arg8 : i32, %arg9 : i32, %arg10 : i32):
  %0 = llvm.xor %arg8, %arg10 : i32
  %1 = llvm.xor %arg9, %arg10 : i32
  %2 = llvm.and %1, %0 : i32
  %3 = llvm.xor %1, %2 : i32
  %4 = llvm.xor %0, %2 : i32
  %5 = llvm.or %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def or_xor_xor_normal_binops_after := [llvm|
{
^0(%arg8 : i32, %arg9 : i32, %arg10 : i32):
  %0 = llvm.xor %arg9, %arg8 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_xor_xor_normal_binops_proof : or_xor_xor_normal_binops_before ⊑ or_xor_xor_normal_binops_after := by
  unfold or_xor_xor_normal_binops_before or_xor_xor_normal_binops_after
  simp_alive_peephole
  intros
  ---BEGIN or_xor_xor_normal_binops
  all_goals (try extract_goal ; sorry)
  ---END or_xor_xor_normal_binops


