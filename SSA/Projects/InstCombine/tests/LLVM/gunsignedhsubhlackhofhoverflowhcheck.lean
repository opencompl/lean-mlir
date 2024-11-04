
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
section gunsignedhsubhlackhofhoverflowhcheck_statements

def t0_basic_before := [llvm|
{
^0(%arg24 : i8, %arg25 : i8):
  %0 = llvm.sub %arg24, %arg25 : i8
  %1 = llvm.icmp "ule" %0, %arg24 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
def t0_basic_after := [llvm|
{
^0(%arg24 : i8, %arg25 : i8):
  %0 = llvm.icmp "ule" %arg25, %arg24 : i8
  "llvm.return"(%0) : (i1) -> ()
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



def t2_commutative_before := [llvm|
{
^0(%arg20 : i8, %arg21 : i8):
  %0 = llvm.sub %arg20, %arg21 : i8
  %1 = llvm.icmp "uge" %arg20, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
def t2_commutative_after := [llvm|
{
^0(%arg20 : i8, %arg21 : i8):
  %0 = llvm.icmp "uge" %arg20, %arg21 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t2_commutative_proof : t2_commutative_before ⊑ t2_commutative_after := by
  unfold t2_commutative_before t2_commutative_after
  simp_alive_peephole
  intros
  ---BEGIN t2_commutative
  all_goals (try extract_goal ; sorry)
  ---END t2_commutative



def n7_wrong_pred2_before := [llvm|
{
^0(%arg10 : i8, %arg11 : i8):
  %0 = llvm.sub %arg10, %arg11 : i8
  %1 = llvm.icmp "eq" %0, %arg10 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
def n7_wrong_pred2_after := [llvm|
{
^0(%arg10 : i8, %arg11 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "eq" %arg11, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem n7_wrong_pred2_proof : n7_wrong_pred2_before ⊑ n7_wrong_pred2_after := by
  unfold n7_wrong_pred2_before n7_wrong_pred2_after
  simp_alive_peephole
  intros
  ---BEGIN n7_wrong_pred2
  all_goals (try extract_goal ; sorry)
  ---END n7_wrong_pred2



def n8_wrong_pred3_before := [llvm|
{
^0(%arg8 : i8, %arg9 : i8):
  %0 = llvm.sub %arg8, %arg9 : i8
  %1 = llvm.icmp "ne" %0, %arg8 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
def n8_wrong_pred3_after := [llvm|
{
^0(%arg8 : i8, %arg9 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "ne" %arg9, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem n8_wrong_pred3_proof : n8_wrong_pred3_before ⊑ n8_wrong_pred3_after := by
  unfold n8_wrong_pred3_before n8_wrong_pred3_after
  simp_alive_peephole
  intros
  ---BEGIN n8_wrong_pred3
  all_goals (try extract_goal ; sorry)
  ---END n8_wrong_pred3


