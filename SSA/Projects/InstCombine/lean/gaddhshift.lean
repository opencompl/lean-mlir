import SSA.Projects.InstCombine.lean.gaddhshift_proof
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import Batteries.Data.BitVec

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)

set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
set_option linter.unreachableTactic false
set_option linter.unusedTactic false
                                                                       
def flip_add_of_shift_neg_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg0 : i8
  %2 = llvm.shl %1, %arg1 : i8
  %3 = llvm.add %2, %arg2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def flip_add_of_shift_neg_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.shl %arg0, %arg1 : i8
  %1 = llvm.sub %arg2, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem flip_add_of_shift_neg_proof : flip_add_of_shift_neg_before ⊑ flip_add_of_shift_neg_after := by
  unfold flip_add_of_shift_neg_before flip_add_of_shift_neg_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN flip_add_of_shift_neg
  apply flip_add_of_shift_neg_thm
  ---END flip_add_of_shift_neg


