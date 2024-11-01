
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
section g2008h02h16hSDivOverflow2_statements

def i_before := [llvm|
{
^0(%arg0 : i8):
  %0 = llvm.mlir.constant(-3 : i8) : i8
  %1 = llvm.sdiv %arg0, %0 : i8
  %2 = llvm.sdiv %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def i_after := [llvm|
{
^0(%arg0 : i8):
  %0 = llvm.mlir.constant(9 : i8) : i8
  %1 = llvm.sdiv %arg0, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem i_proof : i_before ⊑ i_after := by
  unfold i_before i_after
  simp_alive_peephole
  intros
  ---BEGIN i
  all_goals (try extract_goal ; sorry)
  ---END i


