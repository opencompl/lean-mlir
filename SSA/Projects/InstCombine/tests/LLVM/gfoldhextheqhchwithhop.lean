
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
section gfoldhextheqhchwithhop_statements

def fold_add_zext_eq_0_before := [llvm|
{
^0(%arg4 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "eq" %arg4, %0 : i8
  %2 = llvm.zext %1 : i1 to i8
  %3 = llvm.add %arg4, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def fold_add_zext_eq_0_after := [llvm|
{
^0(%arg4 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "eq" %arg4, %0 : i8
  %2 = llvm.zext %1 : i1 to i8
  %3 = llvm.add %2, %arg4 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem fold_add_zext_eq_0_proof : fold_add_zext_eq_0_before ⊑ fold_add_zext_eq_0_after := by
  unfold fold_add_zext_eq_0_before fold_add_zext_eq_0_after
  simp_alive_peephole
  intros
  ---BEGIN fold_add_zext_eq_0
  all_goals (try extract_goal ; sorry)
  ---END fold_add_zext_eq_0


