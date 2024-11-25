
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
section gicmphsignmask_statements

def cmp_x_and_negp2_with_eq_before := [llvm|
{
^0(%arg4 : i8):
  %0 = llvm.mlir.constant(-2 : i8) : i8
  %1 = llvm.mlir.constant(-128 : i8) : i8
  %2 = llvm.and %arg4, %0 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def cmp_x_and_negp2_with_eq_after := [llvm|
{
^0(%arg4 : i8):
  %0 = llvm.mlir.constant(-126 : i8) : i8
  %1 = llvm.icmp "slt" %arg4, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem cmp_x_and_negp2_with_eq_proof : cmp_x_and_negp2_with_eq_before ⊑ cmp_x_and_negp2_with_eq_after := by
  unfold cmp_x_and_negp2_with_eq_before cmp_x_and_negp2_with_eq_after
  simp_alive_peephole
  intros
  ---BEGIN cmp_x_and_negp2_with_eq
  all_goals (try extract_goal ; sorry)
  ---END cmp_x_and_negp2_with_eq


