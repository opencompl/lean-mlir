
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
section gcanonicalizehlowhbithmaskhandhicmphnehtohicmphugt_statements

def p0_before := [llvm|
{
^0(%arg16 : i8, %arg17 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.lshr %0, %arg17 : i8
  %2 = llvm.and %1, %arg16 : i8
  %3 = llvm.icmp "ne" %2, %arg16 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def p0_after := [llvm|
{
^0(%arg16 : i8, %arg17 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.lshr %0, %arg17 : i8
  %2 = llvm.icmp "ugt" %arg16, %1 : i8
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


