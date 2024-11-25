
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
section gomithuremhofhpowerhofhtwohorhzerohwhenhcomparinghwithhzero_statements

def p0_scalar_urem_by_const_before := [llvm|
{
^0(%arg20 : i32, %arg21 : i32):
  %0 = llvm.mlir.constant(128 : i32) : i32
  %1 = llvm.mlir.constant(6 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.and %arg20, %0 : i32
  %4 = llvm.urem %3, %1 : i32
  %5 = llvm.icmp "eq" %4, %2 : i32
  "llvm.return"(%5) : (i1) -> ()
}
]
def p0_scalar_urem_by_const_after := [llvm|
{
^0(%arg20 : i32, %arg21 : i32):
  %0 = llvm.mlir.constant(128 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg20, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem p0_scalar_urem_by_const_proof : p0_scalar_urem_by_const_before ⊑ p0_scalar_urem_by_const_after := by
  unfold p0_scalar_urem_by_const_before p0_scalar_urem_by_const_after
  simp_alive_peephole
  intros
  ---BEGIN p0_scalar_urem_by_const
  all_goals (try extract_goal ; sorry)
  ---END p0_scalar_urem_by_const



def p1_scalar_urem_by_nonconst_before := [llvm|
{
^0(%arg18 : i32, %arg19 : i32):
  %0 = llvm.mlir.constant(128 : i32) : i32
  %1 = llvm.mlir.constant(6 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.and %arg18, %0 : i32
  %4 = llvm.or %arg19, %1 : i32
  %5 = llvm.urem %3, %4 : i32
  %6 = llvm.icmp "eq" %5, %2 : i32
  "llvm.return"(%6) : (i1) -> ()
}
]
def p1_scalar_urem_by_nonconst_after := [llvm|
{
^0(%arg18 : i32, %arg19 : i32):
  %0 = llvm.mlir.constant(128 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg18, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem p1_scalar_urem_by_nonconst_proof : p1_scalar_urem_by_nonconst_before ⊑ p1_scalar_urem_by_nonconst_after := by
  unfold p1_scalar_urem_by_nonconst_before p1_scalar_urem_by_nonconst_after
  simp_alive_peephole
  intros
  ---BEGIN p1_scalar_urem_by_nonconst
  all_goals (try extract_goal ; sorry)
  ---END p1_scalar_urem_by_nonconst



def p2_scalar_shifted_urem_by_const_before := [llvm|
{
^0(%arg16 : i32, %arg17 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(3 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.and %arg16, %0 : i32
  %4 = llvm.shl %3, %arg17 : i32
  %5 = llvm.urem %4, %1 : i32
  %6 = llvm.icmp "eq" %5, %2 : i32
  "llvm.return"(%6) : (i1) -> ()
}
]
def p2_scalar_shifted_urem_by_const_after := [llvm|
{
^0(%arg16 : i32, %arg17 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(3 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.and %arg16, %0 : i32
  %4 = llvm.shl %3, %arg17 overflow<nuw> : i32
  %5 = llvm.urem %4, %1 : i32
  %6 = llvm.icmp "eq" %5, %2 : i32
  "llvm.return"(%6) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem p2_scalar_shifted_urem_by_const_proof : p2_scalar_shifted_urem_by_const_before ⊑ p2_scalar_shifted_urem_by_const_after := by
  unfold p2_scalar_shifted_urem_by_const_before p2_scalar_shifted_urem_by_const_after
  simp_alive_peephole
  intros
  ---BEGIN p2_scalar_shifted_urem_by_const
  all_goals (try extract_goal ; sorry)
  ---END p2_scalar_shifted_urem_by_const


