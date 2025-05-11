
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
section gapinthcasthcasthtohand_statements

def test1_before := [llvm|
{
^0(%arg0 : i61):
  %0 = llvm.trunc %arg0 : i61 to i41
  %1 = llvm.zext %0 : i41 to i61
  "llvm.return"(%1) : (i61) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg0 : i61):
  %0 = llvm.mlir.constant(2199023255551 : i61) : i61
  %1 = llvm.and %arg0, %0 : i61
  "llvm.return"(%1) : (i61) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test1_proof : test1_before ⊑ test1_after := by
  unfold test1_before test1_after
  simp_alive_peephole
  intros
  ---BEGIN test1
  all_goals (try extract_goal ; sorry)
  ---END test1


