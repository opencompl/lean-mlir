
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
section gmergehicmp_statements

def or_basic_before := [llvm|
{
^0(%arg15 : i16):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.mlir.constant(-256 : i16) : i16
  %2 = llvm.mlir.constant(17664 : i16) : i16
  %3 = llvm.trunc %arg15 : i16 to i8
  %4 = llvm.icmp "ne" %3, %0 : i8
  %5 = llvm.and %arg15, %1 : i16
  %6 = llvm.icmp "ne" %5, %2 : i16
  %7 = llvm.or %4, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def or_basic_after := [llvm|
{
^0(%arg15 : i16):
  %0 = llvm.mlir.constant(17791 : i16) : i16
  %1 = llvm.icmp "ne" %arg15, %0 : i16
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_basic_proof : or_basic_before ⊑ or_basic_after := by
  unfold or_basic_before or_basic_after
  simp_alive_peephole
  intros
  ---BEGIN or_basic
  all_goals (try extract_goal ; sorry)
  ---END or_basic



def or_basic_commuted_before := [llvm|
{
^0(%arg14 : i16):
  %0 = llvm.mlir.constant(-256 : i16) : i16
  %1 = llvm.mlir.constant(32512 : i16) : i16
  %2 = llvm.mlir.constant(69 : i8) : i8
  %3 = llvm.and %arg14, %0 : i16
  %4 = llvm.icmp "ne" %3, %1 : i16
  %5 = llvm.trunc %arg14 : i16 to i8
  %6 = llvm.icmp "ne" %5, %2 : i8
  %7 = llvm.or %4, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def or_basic_commuted_after := [llvm|
{
^0(%arg14 : i16):
  %0 = llvm.mlir.constant(32581 : i16) : i16
  %1 = llvm.icmp "ne" %arg14, %0 : i16
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_basic_commuted_proof : or_basic_commuted_before ⊑ or_basic_commuted_after := by
  unfold or_basic_commuted_before or_basic_commuted_after
  simp_alive_peephole
  intros
  ---BEGIN or_basic_commuted
  all_goals (try extract_goal ; sorry)
  ---END or_basic_commuted



def or_nontrivial_mask1_before := [llvm|
{
^0(%arg12 : i16):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.mlir.constant(3840 : i16) : i16
  %2 = llvm.mlir.constant(1280 : i16) : i16
  %3 = llvm.trunc %arg12 : i16 to i8
  %4 = llvm.icmp "ne" %3, %0 : i8
  %5 = llvm.and %arg12, %1 : i16
  %6 = llvm.icmp "ne" %5, %2 : i16
  %7 = llvm.or %4, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def or_nontrivial_mask1_after := [llvm|
{
^0(%arg12 : i16):
  %0 = llvm.mlir.constant(4095 : i16) : i16
  %1 = llvm.mlir.constant(1407 : i16) : i16
  %2 = llvm.and %arg12, %0 : i16
  %3 = llvm.icmp "ne" %2, %1 : i16
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_nontrivial_mask1_proof : or_nontrivial_mask1_before ⊑ or_nontrivial_mask1_after := by
  unfold or_nontrivial_mask1_before or_nontrivial_mask1_after
  simp_alive_peephole
  intros
  ---BEGIN or_nontrivial_mask1
  all_goals (try extract_goal ; sorry)
  ---END or_nontrivial_mask1



def or_nontrivial_mask2_before := [llvm|
{
^0(%arg11 : i16):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.mlir.constant(-4096 : i16) : i16
  %2 = llvm.mlir.constant(20480 : i16) : i16
  %3 = llvm.trunc %arg11 : i16 to i8
  %4 = llvm.icmp "ne" %3, %0 : i8
  %5 = llvm.and %arg11, %1 : i16
  %6 = llvm.icmp "ne" %5, %2 : i16
  %7 = llvm.or %4, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def or_nontrivial_mask2_after := [llvm|
{
^0(%arg11 : i16):
  %0 = llvm.mlir.constant(-3841 : i16) : i16
  %1 = llvm.mlir.constant(20607 : i16) : i16
  %2 = llvm.and %arg11, %0 : i16
  %3 = llvm.icmp "ne" %2, %1 : i16
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_nontrivial_mask2_proof : or_nontrivial_mask2_before ⊑ or_nontrivial_mask2_after := by
  unfold or_nontrivial_mask2_before or_nontrivial_mask2_after
  simp_alive_peephole
  intros
  ---BEGIN or_nontrivial_mask2
  all_goals (try extract_goal ; sorry)
  ---END or_nontrivial_mask2



def or_wrong_const1_before := [llvm|
{
^0(%arg1 : i16):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.mlir.constant(-256 : i16) : i16
  %2 = llvm.mlir.constant(17665 : i16) : i16
  %3 = llvm.trunc %arg1 : i16 to i8
  %4 = llvm.icmp "ne" %3, %0 : i8
  %5 = llvm.and %arg1, %1 : i16
  %6 = llvm.icmp "ne" %5, %2 : i16
  %7 = llvm.or %4, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def or_wrong_const1_after := [llvm|
{
^0(%arg1 : i16):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_wrong_const1_proof : or_wrong_const1_before ⊑ or_wrong_const1_after := by
  unfold or_wrong_const1_before or_wrong_const1_after
  simp_alive_peephole
  intros
  ---BEGIN or_wrong_const1
  all_goals (try extract_goal ; sorry)
  ---END or_wrong_const1


