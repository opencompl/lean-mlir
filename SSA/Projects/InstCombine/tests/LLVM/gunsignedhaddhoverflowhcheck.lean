
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
section gunsignedhaddhoverflowhcheck_statements

def t0_basic_before := [llvm|
{
^0(%arg29 : i8, %arg30 : i8):
  %0 = llvm.add %arg29, %arg30 : i8
  %1 = llvm.icmp "ult" %0, %arg30 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
def t0_basic_after := [llvm|
{
^0(%arg29 : i8, %arg30 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.xor %arg30, %0 : i8
  %2 = llvm.icmp "ugt" %arg29, %1 : i8
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
^0(%arg25 : i8, %arg26 : i8):
  %0 = llvm.add %arg25, %arg26 : i8
  %1 = llvm.icmp "ult" %0, %arg25 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
def t2_symmetry_after := [llvm|
{
^0(%arg25 : i8, %arg26 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.xor %arg25, %0 : i8
  %2 = llvm.icmp "ugt" %arg26, %1 : i8
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
^0(%arg22 : i8, %arg23 : i8):
  %0 = llvm.add %arg22, %arg23 : i8
  %1 = llvm.icmp "ugt" %arg23, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
def t4_commutative_after := [llvm|
{
^0(%arg22 : i8, %arg23 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.xor %arg23, %0 : i8
  %2 = llvm.icmp "ugt" %arg22, %1 : i8
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
^0(%arg10 : i8, %arg11 : i8):
  %0 = llvm.add %arg10, %arg11 : i8
  %1 = llvm.icmp "eq" %0, %arg11 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
def n10_wrong_pred2_after := [llvm|
{
^0(%arg10 : i8, %arg11 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "eq" %arg10, %0 : i8
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
^0(%arg8 : i8, %arg9 : i8):
  %0 = llvm.add %arg8, %arg9 : i8
  %1 = llvm.icmp "ne" %0, %arg9 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
def n11_wrong_pred3_after := [llvm|
{
^0(%arg8 : i8, %arg9 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "ne" %arg8, %0 : i8
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


