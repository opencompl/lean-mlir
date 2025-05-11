
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
section gicmphugthofhshlh1hbyhbitshandhvalhtohicmpheqhofhlshrhvalhbyhbitshandh0_statements

def p0_before := [llvm|
{
^0(%arg16 : i8, %arg17 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.shl %0, %arg17 : i8
  %2 = llvm.icmp "ugt" %1, %arg16 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def p0_after := [llvm|
{
^0(%arg16 : i8, %arg17 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.lshr %arg16, %arg17 : i8
  %2 = llvm.icmp "eq" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem p0_proof : p0_before ⊑ p0_after := by
  unfold p0_before p0_after
  simp_alive_peephole
  intros
  ---BEGIN p0
  all_goals (try extract_goal ; sorry)
  ---END p0



def both_before := [llvm|
{
^0(%arg9 : i8, %arg10 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.shl %0, %arg9 : i8
  %2 = llvm.shl %0, %arg10 : i8
  %3 = llvm.icmp "ugt" %1, %2 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def both_after := [llvm|
{
^0(%arg9 : i8, %arg10 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.shl %0, %arg10 overflow<nuw> : i8
  %3 = llvm.lshr %2, %arg9 : i8
  %4 = llvm.icmp "eq" %3, %1 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem both_proof : both_before ⊑ both_after := by
  unfold both_before both_after
  simp_alive_peephole
  intros
  ---BEGIN both
  all_goals (try extract_goal ; sorry)
  ---END both



def n2_before := [llvm|
{
^0(%arg1 : i8, %arg2 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.shl %0, %arg2 : i8
  %2 = llvm.icmp "uge" %1, %arg1 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def n2_after := [llvm|
{
^0(%arg1 : i8, %arg2 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.shl %0, %arg2 overflow<nuw> : i8
  %2 = llvm.icmp "uge" %1, %arg1 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem n2_proof : n2_before ⊑ n2_after := by
  unfold n2_before n2_after
  simp_alive_peephole
  intros
  ---BEGIN n2
  all_goals (try extract_goal ; sorry)
  ---END n2


