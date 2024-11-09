
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
section ghoisthxorhbyhconstanthfromhxorhbyhvalue_statements

def t0_scalar_before := [llvm|
{
^0(%arg10 : i8, %arg11 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.xor %arg10, %0 : i8
  %2 = llvm.xor %1, %arg11 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def t0_scalar_after := [llvm|
{
^0(%arg10 : i8, %arg11 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.xor %arg10, %arg11 : i8
  %2 = llvm.xor %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t0_scalar_proof : t0_scalar_before ⊑ t0_scalar_after := by
  unfold t0_scalar_before t0_scalar_after
  simp_alive_peephole
  intros
  ---BEGIN t0_scalar
  all_goals (try extract_goal ; sorry)
  ---END t0_scalar


