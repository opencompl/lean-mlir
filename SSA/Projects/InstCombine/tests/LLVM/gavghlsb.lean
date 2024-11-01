
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
section gavghlsb_statements

def avg_lsb_before := [llvm|
{
^0(%arg4 : i8, %arg5 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.and %arg4, %0 : i8
  %2 = llvm.and %arg5, %0 : i8
  %3 = llvm.add %2, %1 overflow<nsw,nuw> : i8
  %4 = llvm.lshr %3, %0 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def avg_lsb_after := [llvm|
{
^0(%arg4 : i8, %arg5 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.and %arg4, %0 : i8
  %2 = llvm.and %arg5, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem avg_lsb_proof : avg_lsb_before ⊑ avg_lsb_after := by
  unfold avg_lsb_before avg_lsb_after
  simp_alive_peephole
  intros
  ---BEGIN avg_lsb
  all_goals (try extract_goal ; sorry)
  ---END avg_lsb


