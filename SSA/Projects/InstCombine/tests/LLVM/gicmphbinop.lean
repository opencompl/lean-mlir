
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
section gicmphbinop_statements

def mul_unkV_oddC_eq_before := [llvm|
{
^0(%arg27 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mul %arg27, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def mul_unkV_oddC_eq_after := [llvm|
{
^0(%arg27 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "eq" %arg27, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul_unkV_oddC_eq_proof : mul_unkV_oddC_eq_before ⊑ mul_unkV_oddC_eq_after := by
  unfold mul_unkV_oddC_eq_before mul_unkV_oddC_eq_after
  simp_alive_peephole
  intros
  ---BEGIN mul_unkV_oddC_eq
  all_goals (try extract_goal ; sorry)
  ---END mul_unkV_oddC_eq



def mul_unkV_oddC_sge_before := [llvm|
{
^0(%arg22 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.mul %arg22, %0 : i8
  %3 = llvm.icmp "sge" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def mul_unkV_oddC_sge_after := [llvm|
{
^0(%arg22 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.mul %arg22, %0 : i8
  %3 = llvm.icmp "sgt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul_unkV_oddC_sge_proof : mul_unkV_oddC_sge_before ⊑ mul_unkV_oddC_sge_after := by
  unfold mul_unkV_oddC_sge_before mul_unkV_oddC_sge_after
  simp_alive_peephole
  intros
  ---BEGIN mul_unkV_oddC_sge
  all_goals (try extract_goal ; sorry)
  ---END mul_unkV_oddC_sge



def mul_unkV_evenC_ne_before := [llvm|
{
^0(%arg12 : i64):
  %0 = llvm.mlir.constant(4) : i64
  %1 = llvm.mlir.constant(0) : i64
  %2 = llvm.mul %arg12, %0 : i64
  %3 = llvm.icmp "ne" %2, %1 : i64
  "llvm.return"(%3) : (i1) -> ()
}
]
def mul_unkV_evenC_ne_after := [llvm|
{
^0(%arg12 : i64):
  %0 = llvm.mlir.constant(4611686018427387903) : i64
  %1 = llvm.mlir.constant(0) : i64
  %2 = llvm.and %arg12, %0 : i64
  %3 = llvm.icmp "ne" %2, %1 : i64
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul_unkV_evenC_ne_proof : mul_unkV_evenC_ne_before ⊑ mul_unkV_evenC_ne_after := by
  unfold mul_unkV_evenC_ne_before mul_unkV_evenC_ne_after
  simp_alive_peephole
  intros
  ---BEGIN mul_unkV_evenC_ne
  all_goals (try extract_goal ; sorry)
  ---END mul_unkV_evenC_ne



def mul_setnzV_unkV_nuw_eq_before := [llvm|
{
^0(%arg2 : i8, %arg3 : i8):
  %0 = llvm.mlir.constant(2 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.or %arg2, %0 : i8
  %3 = llvm.mul %2, %arg3 overflow<nuw> : i8
  %4 = llvm.icmp "eq" %3, %1 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
def mul_setnzV_unkV_nuw_eq_after := [llvm|
{
^0(%arg2 : i8, %arg3 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "eq" %arg3, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul_setnzV_unkV_nuw_eq_proof : mul_setnzV_unkV_nuw_eq_before ⊑ mul_setnzV_unkV_nuw_eq_after := by
  unfold mul_setnzV_unkV_nuw_eq_before mul_setnzV_unkV_nuw_eq_after
  simp_alive_peephole
  intros
  ---BEGIN mul_setnzV_unkV_nuw_eq
  all_goals (try extract_goal ; sorry)
  ---END mul_setnzV_unkV_nuw_eq


