
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
section gunsignedhaddhlackhofhoverflowhcheck_statements

def t0_basic_before := [llvm|
{
^0(%arg41 : i8, %arg42 : i8):
  %0 = llvm.add %arg41, %arg42 : i8
  %1 = llvm.icmp "uge" %0, %arg42 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
def t0_basic_after := [llvm|
{
^0(%arg41 : i8, %arg42 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.xor %arg42, %0 : i8
  %2 = llvm.icmp "ule" %arg41, %1 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t0_basic_proof : t0_basic_before ⊑ t0_basic_after := by
  unfold t0_basic_before t0_basic_after
  simp_alive_peephole
  intros
  ---BEGIN t0_basic
  all_goals (try extract_goal ; sorry)
  ---END t0_basic



def t2_symmetry_before := [llvm|
{
^0(%arg37 : i8, %arg38 : i8):
  %0 = llvm.add %arg37, %arg38 : i8
  %1 = llvm.icmp "uge" %0, %arg37 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
def t2_symmetry_after := [llvm|
{
^0(%arg37 : i8, %arg38 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.xor %arg37, %0 : i8
  %2 = llvm.icmp "ule" %arg38, %1 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t2_symmetry_proof : t2_symmetry_before ⊑ t2_symmetry_after := by
  unfold t2_symmetry_before t2_symmetry_after
  simp_alive_peephole
  intros
  ---BEGIN t2_symmetry
  all_goals (try extract_goal ; sorry)
  ---END t2_symmetry



def t4_commutative_before := [llvm|
{
^0(%arg34 : i8, %arg35 : i8):
  %0 = llvm.add %arg34, %arg35 : i8
  %1 = llvm.icmp "ule" %arg35, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
def t4_commutative_after := [llvm|
{
^0(%arg34 : i8, %arg35 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.xor %arg35, %0 : i8
  %2 = llvm.icmp "ule" %arg34, %1 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t4_commutative_proof : t4_commutative_before ⊑ t4_commutative_after := by
  unfold t4_commutative_before t4_commutative_after
  simp_alive_peephole
  intros
  ---BEGIN t4_commutative
  all_goals (try extract_goal ; sorry)
  ---END t4_commutative



def n10_wrong_pred2_before := [llvm|
{
^0(%arg22 : i8, %arg23 : i8):
  %0 = llvm.add %arg22, %arg23 : i8
  %1 = llvm.icmp "eq" %0, %arg23 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
def n10_wrong_pred2_after := [llvm|
{
^0(%arg22 : i8, %arg23 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "eq" %arg22, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem n10_wrong_pred2_proof : n10_wrong_pred2_before ⊑ n10_wrong_pred2_after := by
  unfold n10_wrong_pred2_before n10_wrong_pred2_after
  simp_alive_peephole
  intros
  ---BEGIN n10_wrong_pred2
  all_goals (try extract_goal ; sorry)
  ---END n10_wrong_pred2



def n11_wrong_pred3_before := [llvm|
{
^0(%arg20 : i8, %arg21 : i8):
  %0 = llvm.add %arg20, %arg21 : i8
  %1 = llvm.icmp "ne" %0, %arg21 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
def n11_wrong_pred3_after := [llvm|
{
^0(%arg20 : i8, %arg21 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "ne" %arg20, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem n11_wrong_pred3_proof : n11_wrong_pred3_before ⊑ n11_wrong_pred3_after := by
  unfold n11_wrong_pred3_before n11_wrong_pred3_after
  simp_alive_peephole
  intros
  ---BEGIN n11_wrong_pred3
  all_goals (try extract_goal ; sorry)
  ---END n11_wrong_pred3



def low_bitmask_ult_before := [llvm|
{
^0(%arg11 : i8):
  %0 = llvm.mlir.constant(31 : i8) : i8
  %1 = llvm.add %arg11, %0 : i8
  %2 = llvm.and %1, %0 : i8
  %3 = llvm.icmp "ult" %2, %arg11 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def low_bitmask_ult_after := [llvm|
{
^0(%arg11 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "ne" %arg11, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem low_bitmask_ult_proof : low_bitmask_ult_before ⊑ low_bitmask_ult_after := by
  unfold low_bitmask_ult_before low_bitmask_ult_after
  simp_alive_peephole
  intros
  ---BEGIN low_bitmask_ult
  all_goals (try extract_goal ; sorry)
  ---END low_bitmask_ult



def low_bitmask_ugt_before := [llvm|
{
^0(%arg9 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.mul %arg9, %arg9 : i8
  %2 = llvm.add %1, %0 : i8
  %3 = llvm.and %2, %0 : i8
  %4 = llvm.icmp "ugt" %1, %3 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
def low_bitmask_ugt_after := [llvm|
{
^0(%arg9 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mul %arg9, %arg9 : i8
  %2 = llvm.icmp "ne" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem low_bitmask_ugt_proof : low_bitmask_ugt_before ⊑ low_bitmask_ugt_after := by
  unfold low_bitmask_ugt_before low_bitmask_ugt_after
  simp_alive_peephole
  intros
  ---BEGIN low_bitmask_ugt
  all_goals (try extract_goal ; sorry)
  ---END low_bitmask_ugt


