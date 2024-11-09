import SSA.Projects.InstCombine.tests.proofs.gicmphpower2handhicmphshiftedhmask_proof
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
section gicmphpower2handhicmphshiftedhmask_statements

def icmp_power2_and_icmp_shifted_mask_2147483648_1610612736_before := [llvm|
{
^0(%arg45 : i32):
  %0 = llvm.mlir.constant(-2147483648 : i32) : i32
  %1 = llvm.mlir.constant(1610612736 : i32) : i32
  %2 = llvm.icmp "ult" %arg45, %0 : i32
  %3 = llvm.and %arg45, %1 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  %5 = llvm.and %2, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def icmp_power2_and_icmp_shifted_mask_2147483648_1610612736_after := [llvm|
{
^0(%arg45 : i32):
  %0 = llvm.mlir.constant(1610612736 : i32) : i32
  %1 = llvm.icmp "ult" %arg45, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_power2_and_icmp_shifted_mask_2147483648_1610612736_proof : icmp_power2_and_icmp_shifted_mask_2147483648_1610612736_before ⊑ icmp_power2_and_icmp_shifted_mask_2147483648_1610612736_after := by
  unfold icmp_power2_and_icmp_shifted_mask_2147483648_1610612736_before icmp_power2_and_icmp_shifted_mask_2147483648_1610612736_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_power2_and_icmp_shifted_mask_2147483648_1610612736
  apply icmp_power2_and_icmp_shifted_mask_2147483648_1610612736_thm
  ---END icmp_power2_and_icmp_shifted_mask_2147483648_1610612736



def icmp_power2_and_icmp_shifted_mask_swapped_2147483648_1610612736_before := [llvm|
{
^0(%arg44 : i32):
  %0 = llvm.mlir.constant(-2147483648 : i32) : i32
  %1 = llvm.mlir.constant(1610612736 : i32) : i32
  %2 = llvm.icmp "ult" %arg44, %0 : i32
  %3 = llvm.and %arg44, %1 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  %5 = llvm.and %4, %2 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def icmp_power2_and_icmp_shifted_mask_swapped_2147483648_1610612736_after := [llvm|
{
^0(%arg44 : i32):
  %0 = llvm.mlir.constant(1610612736 : i32) : i32
  %1 = llvm.icmp "ult" %arg44, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_power2_and_icmp_shifted_mask_swapped_2147483648_1610612736_proof : icmp_power2_and_icmp_shifted_mask_swapped_2147483648_1610612736_before ⊑ icmp_power2_and_icmp_shifted_mask_swapped_2147483648_1610612736_after := by
  unfold icmp_power2_and_icmp_shifted_mask_swapped_2147483648_1610612736_before icmp_power2_and_icmp_shifted_mask_swapped_2147483648_1610612736_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_power2_and_icmp_shifted_mask_swapped_2147483648_1610612736
  apply icmp_power2_and_icmp_shifted_mask_swapped_2147483648_1610612736_thm
  ---END icmp_power2_and_icmp_shifted_mask_swapped_2147483648_1610612736



def icmp_power2_and_icmp_shifted_mask_2147483648_2147483647_before := [llvm|
{
^0(%arg43 : i32):
  %0 = llvm.mlir.constant(-2147483648 : i32) : i32
  %1 = llvm.mlir.constant(2147483647 : i32) : i32
  %2 = llvm.icmp "ult" %arg43, %0 : i32
  %3 = llvm.and %arg43, %1 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  %5 = llvm.and %2, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def icmp_power2_and_icmp_shifted_mask_2147483648_2147483647_after := [llvm|
{
^0(%arg43 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.icmp "ult" %arg43, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_power2_and_icmp_shifted_mask_2147483648_2147483647_proof : icmp_power2_and_icmp_shifted_mask_2147483648_2147483647_before ⊑ icmp_power2_and_icmp_shifted_mask_2147483648_2147483647_after := by
  unfold icmp_power2_and_icmp_shifted_mask_2147483648_2147483647_before icmp_power2_and_icmp_shifted_mask_2147483648_2147483647_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_power2_and_icmp_shifted_mask_2147483648_2147483647
  apply icmp_power2_and_icmp_shifted_mask_2147483648_2147483647_thm
  ---END icmp_power2_and_icmp_shifted_mask_2147483648_2147483647



def icmp_power2_and_icmp_shifted_mask_swapped_2147483648_2147483647_before := [llvm|
{
^0(%arg42 : i32):
  %0 = llvm.mlir.constant(-2147483648 : i32) : i32
  %1 = llvm.mlir.constant(2147483647 : i32) : i32
  %2 = llvm.icmp "ult" %arg42, %0 : i32
  %3 = llvm.and %arg42, %1 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  %5 = llvm.and %4, %2 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def icmp_power2_and_icmp_shifted_mask_swapped_2147483648_2147483647_after := [llvm|
{
^0(%arg42 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.icmp "ult" %arg42, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_power2_and_icmp_shifted_mask_swapped_2147483648_2147483647_proof : icmp_power2_and_icmp_shifted_mask_swapped_2147483648_2147483647_before ⊑ icmp_power2_and_icmp_shifted_mask_swapped_2147483648_2147483647_after := by
  unfold icmp_power2_and_icmp_shifted_mask_swapped_2147483648_2147483647_before icmp_power2_and_icmp_shifted_mask_swapped_2147483648_2147483647_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_power2_and_icmp_shifted_mask_swapped_2147483648_2147483647
  apply icmp_power2_and_icmp_shifted_mask_swapped_2147483648_2147483647_thm
  ---END icmp_power2_and_icmp_shifted_mask_swapped_2147483648_2147483647



def icmp_power2_and_icmp_shifted_mask_2147483648_805306368_before := [llvm|
{
^0(%arg41 : i32):
  %0 = llvm.mlir.constant(1073741824 : i32) : i32
  %1 = llvm.mlir.constant(805306368 : i32) : i32
  %2 = llvm.icmp "ult" %arg41, %0 : i32
  %3 = llvm.and %arg41, %1 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  %5 = llvm.and %2, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def icmp_power2_and_icmp_shifted_mask_2147483648_805306368_after := [llvm|
{
^0(%arg41 : i32):
  %0 = llvm.mlir.constant(805306368 : i32) : i32
  %1 = llvm.icmp "ult" %arg41, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_power2_and_icmp_shifted_mask_2147483648_805306368_proof : icmp_power2_and_icmp_shifted_mask_2147483648_805306368_before ⊑ icmp_power2_and_icmp_shifted_mask_2147483648_805306368_after := by
  unfold icmp_power2_and_icmp_shifted_mask_2147483648_805306368_before icmp_power2_and_icmp_shifted_mask_2147483648_805306368_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_power2_and_icmp_shifted_mask_2147483648_805306368
  apply icmp_power2_and_icmp_shifted_mask_2147483648_805306368_thm
  ---END icmp_power2_and_icmp_shifted_mask_2147483648_805306368



def icmp_power2_and_icmp_shifted_mask_swapped_2147483648_805306368_before := [llvm|
{
^0(%arg40 : i32):
  %0 = llvm.mlir.constant(1073741824 : i32) : i32
  %1 = llvm.mlir.constant(805306368 : i32) : i32
  %2 = llvm.icmp "ult" %arg40, %0 : i32
  %3 = llvm.and %arg40, %1 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  %5 = llvm.and %4, %2 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def icmp_power2_and_icmp_shifted_mask_swapped_2147483648_805306368_after := [llvm|
{
^0(%arg40 : i32):
  %0 = llvm.mlir.constant(805306368 : i32) : i32
  %1 = llvm.icmp "ult" %arg40, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_power2_and_icmp_shifted_mask_swapped_2147483648_805306368_proof : icmp_power2_and_icmp_shifted_mask_swapped_2147483648_805306368_before ⊑ icmp_power2_and_icmp_shifted_mask_swapped_2147483648_805306368_after := by
  unfold icmp_power2_and_icmp_shifted_mask_swapped_2147483648_805306368_before icmp_power2_and_icmp_shifted_mask_swapped_2147483648_805306368_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_power2_and_icmp_shifted_mask_swapped_2147483648_805306368
  apply icmp_power2_and_icmp_shifted_mask_swapped_2147483648_805306368_thm
  ---END icmp_power2_and_icmp_shifted_mask_swapped_2147483648_805306368



def icmp_power2_and_icmp_shifted_mask_1073741824_1073741823_before := [llvm|
{
^0(%arg39 : i32):
  %0 = llvm.mlir.constant(1073741824 : i32) : i32
  %1 = llvm.mlir.constant(1073741823 : i32) : i32
  %2 = llvm.icmp "ult" %arg39, %0 : i32
  %3 = llvm.and %arg39, %1 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  %5 = llvm.and %2, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def icmp_power2_and_icmp_shifted_mask_1073741824_1073741823_after := [llvm|
{
^0(%arg39 : i32):
  %0 = llvm.mlir.constant(1073741823 : i32) : i32
  %1 = llvm.icmp "ult" %arg39, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_power2_and_icmp_shifted_mask_1073741824_1073741823_proof : icmp_power2_and_icmp_shifted_mask_1073741824_1073741823_before ⊑ icmp_power2_and_icmp_shifted_mask_1073741824_1073741823_after := by
  unfold icmp_power2_and_icmp_shifted_mask_1073741824_1073741823_before icmp_power2_and_icmp_shifted_mask_1073741824_1073741823_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_power2_and_icmp_shifted_mask_1073741824_1073741823
  apply icmp_power2_and_icmp_shifted_mask_1073741824_1073741823_thm
  ---END icmp_power2_and_icmp_shifted_mask_1073741824_1073741823



def icmp_power2_and_icmp_shifted_mask_swapped_1073741824_1073741823_before := [llvm|
{
^0(%arg38 : i32):
  %0 = llvm.mlir.constant(1073741824 : i32) : i32
  %1 = llvm.mlir.constant(1073741823 : i32) : i32
  %2 = llvm.icmp "ult" %arg38, %0 : i32
  %3 = llvm.and %arg38, %1 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  %5 = llvm.and %4, %2 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def icmp_power2_and_icmp_shifted_mask_swapped_1073741824_1073741823_after := [llvm|
{
^0(%arg38 : i32):
  %0 = llvm.mlir.constant(1073741823 : i32) : i32
  %1 = llvm.icmp "ult" %arg38, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_power2_and_icmp_shifted_mask_swapped_1073741824_1073741823_proof : icmp_power2_and_icmp_shifted_mask_swapped_1073741824_1073741823_before ⊑ icmp_power2_and_icmp_shifted_mask_swapped_1073741824_1073741823_after := by
  unfold icmp_power2_and_icmp_shifted_mask_swapped_1073741824_1073741823_before icmp_power2_and_icmp_shifted_mask_swapped_1073741824_1073741823_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_power2_and_icmp_shifted_mask_swapped_1073741824_1073741823
  apply icmp_power2_and_icmp_shifted_mask_swapped_1073741824_1073741823_thm
  ---END icmp_power2_and_icmp_shifted_mask_swapped_1073741824_1073741823



def icmp_power2_and_icmp_shifted_mask_8_7_before := [llvm|
{
^0(%arg37 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(7 : i32) : i32
  %2 = llvm.icmp "ult" %arg37, %0 : i32
  %3 = llvm.and %arg37, %1 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  %5 = llvm.and %2, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def icmp_power2_and_icmp_shifted_mask_8_7_after := [llvm|
{
^0(%arg37 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.icmp "ult" %arg37, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_power2_and_icmp_shifted_mask_8_7_proof : icmp_power2_and_icmp_shifted_mask_8_7_before ⊑ icmp_power2_and_icmp_shifted_mask_8_7_after := by
  unfold icmp_power2_and_icmp_shifted_mask_8_7_before icmp_power2_and_icmp_shifted_mask_8_7_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_power2_and_icmp_shifted_mask_8_7
  apply icmp_power2_and_icmp_shifted_mask_8_7_thm
  ---END icmp_power2_and_icmp_shifted_mask_8_7



def icmp_power2_and_icmp_shifted_mask_swapped_8_7_before := [llvm|
{
^0(%arg36 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(7 : i32) : i32
  %2 = llvm.icmp "ult" %arg36, %0 : i32
  %3 = llvm.and %arg36, %1 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  %5 = llvm.and %4, %2 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def icmp_power2_and_icmp_shifted_mask_swapped_8_7_after := [llvm|
{
^0(%arg36 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.icmp "ult" %arg36, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_power2_and_icmp_shifted_mask_swapped_8_7_proof : icmp_power2_and_icmp_shifted_mask_swapped_8_7_before ⊑ icmp_power2_and_icmp_shifted_mask_swapped_8_7_after := by
  unfold icmp_power2_and_icmp_shifted_mask_swapped_8_7_before icmp_power2_and_icmp_shifted_mask_swapped_8_7_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_power2_and_icmp_shifted_mask_swapped_8_7
  apply icmp_power2_and_icmp_shifted_mask_swapped_8_7_thm
  ---END icmp_power2_and_icmp_shifted_mask_swapped_8_7



def icmp_power2_and_icmp_shifted_mask_8_6_before := [llvm|
{
^0(%arg35 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(6 : i32) : i32
  %2 = llvm.icmp "ult" %arg35, %0 : i32
  %3 = llvm.and %arg35, %1 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  %5 = llvm.and %2, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def icmp_power2_and_icmp_shifted_mask_8_6_after := [llvm|
{
^0(%arg35 : i32):
  %0 = llvm.mlir.constant(6 : i32) : i32
  %1 = llvm.icmp "ult" %arg35, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_power2_and_icmp_shifted_mask_8_6_proof : icmp_power2_and_icmp_shifted_mask_8_6_before ⊑ icmp_power2_and_icmp_shifted_mask_8_6_after := by
  unfold icmp_power2_and_icmp_shifted_mask_8_6_before icmp_power2_and_icmp_shifted_mask_8_6_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_power2_and_icmp_shifted_mask_8_6
  apply icmp_power2_and_icmp_shifted_mask_8_6_thm
  ---END icmp_power2_and_icmp_shifted_mask_8_6



def icmp_power2_and_icmp_shifted_mask_swapped_8_6_before := [llvm|
{
^0(%arg34 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(6 : i32) : i32
  %2 = llvm.icmp "ult" %arg34, %0 : i32
  %3 = llvm.and %arg34, %1 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  %5 = llvm.and %4, %2 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def icmp_power2_and_icmp_shifted_mask_swapped_8_6_after := [llvm|
{
^0(%arg34 : i32):
  %0 = llvm.mlir.constant(6 : i32) : i32
  %1 = llvm.icmp "ult" %arg34, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_power2_and_icmp_shifted_mask_swapped_8_6_proof : icmp_power2_and_icmp_shifted_mask_swapped_8_6_before ⊑ icmp_power2_and_icmp_shifted_mask_swapped_8_6_after := by
  unfold icmp_power2_and_icmp_shifted_mask_swapped_8_6_before icmp_power2_and_icmp_shifted_mask_swapped_8_6_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_power2_and_icmp_shifted_mask_swapped_8_6
  apply icmp_power2_and_icmp_shifted_mask_swapped_8_6_thm
  ---END icmp_power2_and_icmp_shifted_mask_swapped_8_6


