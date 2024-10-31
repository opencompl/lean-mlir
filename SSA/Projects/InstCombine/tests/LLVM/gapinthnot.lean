
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
section gapinthnot_statements

def test1_before := [llvm|
{
^0(%arg2 : i33):
  %0 = llvm.mlir.constant(-1 : i33) : i33
  %1 = llvm.xor %arg2, %0 : i33
  %2 = llvm.xor %1, %0 : i33
  "llvm.return"(%2) : (i33) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg2 : i33):
  "llvm.return"(%arg2) : (i33) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test1_proof : test1_before ⊑ test1_after := by
  unfold test1_before test1_after
  simp_alive_peephole
  ---BEGIN test1
  all_goals (try extract_goal ; sorry)
  ---END test1


