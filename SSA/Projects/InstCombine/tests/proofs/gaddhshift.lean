import SSA.Projects.InstCombine.tests.proofs.gaddhshift_proof
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
section gaddhshift_statements
<<<<<<< HEAD

=======
                                                    
>>>>>>> 43a49182 (re-ran scripts)
def flip_add_of_shift_neg_before := [llvm|
{
^0(%arg12 : i8, %arg13 : i8, %arg14 : i8):
  %0 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg12 : i8
  %2 = llvm.shl %1, %arg13 overflow<nsw,nuw> : i8
  %3 = llvm.add %2, %arg14 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def flip_add_of_shift_neg_after := [llvm|
{
^0(%arg12 : i8, %arg13 : i8, %arg14 : i8):
  %0 = llvm.shl %arg12, %arg13 : i8
  %1 = llvm.sub %arg14, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem flip_add_of_shift_neg_proof : flip_add_of_shift_neg_before ⊑ flip_add_of_shift_neg_after := by
  unfold flip_add_of_shift_neg_before flip_add_of_shift_neg_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
<<<<<<< HEAD
  try simp
  simp_alive_case_bash
  try intros
=======
  simp_alive_case_bash
  intros
>>>>>>> 43a49182 (re-ran scripts)
  try simp
  ---BEGIN flip_add_of_shift_neg
  apply flip_add_of_shift_neg_thm
  ---END flip_add_of_shift_neg


