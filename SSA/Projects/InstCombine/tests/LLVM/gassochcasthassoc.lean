
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
section gassochcasthassoc_statements

def XorZextXor_before := [llvm|
{
^0(%arg6 : i3):
  %0 = llvm.mlir.constant(3 : i3) : i3
  %1 = llvm.mlir.constant(12 : i5) : i5
  %2 = llvm.xor %arg6, %0 : i3
  %3 = llvm.zext %2 : i3 to i5
  %4 = llvm.xor %3, %1 : i5
  "llvm.return"(%4) : (i5) -> ()
}
]
def XorZextXor_after := [llvm|
{
^0(%arg6 : i3):
  %0 = llvm.mlir.constant(15 : i5) : i5
  %1 = llvm.zext %arg6 : i3 to i5
  %2 = llvm.xor %1, %0 : i5
  "llvm.return"(%2) : (i5) -> ()
}
]
set_option debug.skipKernelTC true in
theorem XorZextXor_proof : XorZextXor_before ⊑ XorZextXor_after := by
  unfold XorZextXor_before XorZextXor_after
  simp_alive_peephole
  intros
  ---BEGIN XorZextXor
  all_goals (try extract_goal ; sorry)
  ---END XorZextXor



def OrZextOr_before := [llvm|
{
^0(%arg4 : i3):
  %0 = llvm.mlir.constant(3 : i3) : i3
  %1 = llvm.mlir.constant(8 : i5) : i5
  %2 = llvm.or %arg4, %0 : i3
  %3 = llvm.zext %2 : i3 to i5
  %4 = llvm.or %3, %1 : i5
  "llvm.return"(%4) : (i5) -> ()
}
]
def OrZextOr_after := [llvm|
{
^0(%arg4 : i3):
  %0 = llvm.mlir.constant(11 : i5) : i5
  %1 = llvm.zext %arg4 : i3 to i5
  %2 = llvm.or %1, %0 : i5
  "llvm.return"(%2) : (i5) -> ()
}
]
set_option debug.skipKernelTC true in
theorem OrZextOr_proof : OrZextOr_before ⊑ OrZextOr_after := by
  unfold OrZextOr_before OrZextOr_after
  simp_alive_peephole
  intros
  ---BEGIN OrZextOr
  all_goals (try extract_goal ; sorry)
  ---END OrZextOr



def AndZextAnd_before := [llvm|
{
^0(%arg2 : i3):
  %0 = llvm.mlir.constant(3 : i3) : i3
  %1 = llvm.mlir.constant(14 : i5) : i5
  %2 = llvm.and %arg2, %0 : i3
  %3 = llvm.zext %2 : i3 to i5
  %4 = llvm.and %3, %1 : i5
  "llvm.return"(%4) : (i5) -> ()
}
]
def AndZextAnd_after := [llvm|
{
^0(%arg2 : i3):
  %0 = llvm.mlir.constant(2 : i3) : i3
  %1 = llvm.and %arg2, %0 : i3
  %2 = llvm.zext nneg %1 : i3 to i5
  "llvm.return"(%2) : (i5) -> ()
}
]
set_option debug.skipKernelTC true in
theorem AndZextAnd_proof : AndZextAnd_before ⊑ AndZextAnd_after := by
  unfold AndZextAnd_before AndZextAnd_after
  simp_alive_peephole
  intros
  ---BEGIN AndZextAnd
  all_goals (try extract_goal ; sorry)
  ---END AndZextAnd



def zext_nneg_before := [llvm|
{
^0(%arg0 : i16):
  %0 = llvm.mlir.constant(32767 : i16) : i16
  %1 = llvm.mlir.constant(8388607 : i24) : i24
  %2 = llvm.and %arg0, %0 : i16
  %3 = llvm.zext nneg %2 : i16 to i24
  %4 = llvm.and %3, %1 : i24
  "llvm.return"(%4) : (i24) -> ()
}
]
def zext_nneg_after := [llvm|
{
^0(%arg0 : i16):
  %0 = llvm.mlir.constant(32767 : i16) : i16
  %1 = llvm.and %arg0, %0 : i16
  %2 = llvm.zext nneg %1 : i16 to i24
  "llvm.return"(%2) : (i24) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_nneg_proof : zext_nneg_before ⊑ zext_nneg_after := by
  unfold zext_nneg_before zext_nneg_after
  simp_alive_peephole
  intros
  ---BEGIN zext_nneg
  all_goals (try extract_goal ; sorry)
  ---END zext_nneg


