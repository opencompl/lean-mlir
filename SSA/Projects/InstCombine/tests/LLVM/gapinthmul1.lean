
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
section gapinthmul1_statements

def test1_before := [llvm|
{
^0(%arg2 : i17):
  %0 = "llvm.mlir.constant"() <{value = 1024 : i17}> : () -> i17
  %1 = llvm.mul %arg2, %0 : i17
  "llvm.return"(%1) : (i17) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg2 : i17):
  %0 = "llvm.mlir.constant"() <{value = 10 : i17}> : () -> i17
  %1 = llvm.shl %arg2, %0 : i17
  "llvm.return"(%1) : (i17) -> ()
}
]
theorem test1_proof : test1_before ⊑ test1_after := by
  unfold test1_before test1_after
  simp_alive_peephole
  ---BEGIN test1
  all_goals (try extract_goal ; sorry)
  ---END test1


