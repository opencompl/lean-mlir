
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
section gapinthmul2_statements

def test1_before := [llvm|
{
^0(%arg2 : i177):
  %0 = llvm.mlir.constant(1 : i177) : i177
  %1 = llvm.mlir.constant(155 : i177) : i177
  %2 = llvm.shl %0, %1 : i177
  %3 = llvm.mul %arg2, %2 : i177
  "llvm.return"(%3) : (i177) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg2 : i177):
  %0 = llvm.mlir.constant(155 : i177) : i177
  %1 = llvm.shl %arg2, %0 : i177
  "llvm.return"(%1) : (i177) -> ()
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


