
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
section grotate_statements

def rotateleft_9_neg_mask_wide_amount_commute_before := [llvm|
{
^0(%arg29 : i9, %arg30 : i33):
  %0 = llvm.mlir.constant(0 : i33) : i33
  %1 = llvm.mlir.constant(8 : i33) : i33
  %2 = llvm.sub %0, %arg30 : i33
  %3 = llvm.and %arg30, %1 : i33
  %4 = llvm.and %2, %1 : i33
  %5 = llvm.zext %arg29 : i9 to i33
  %6 = llvm.shl %5, %3 : i33
  %7 = llvm.lshr %5, %4 : i33
  %8 = llvm.or %6, %7 : i33
  %9 = llvm.trunc %8 : i33 to i9
  "llvm.return"(%9) : (i9) -> ()
}
]
def rotateleft_9_neg_mask_wide_amount_commute_after := [llvm|
{
^0(%arg29 : i9, %arg30 : i33):
  %0 = llvm.mlir.constant(0 : i33) : i33
  %1 = llvm.mlir.constant(8 : i33) : i33
  %2 = llvm.sub %0, %arg30 : i33
  %3 = llvm.and %arg30, %1 : i33
  %4 = llvm.and %2, %1 : i33
  %5 = llvm.zext %arg29 : i9 to i33
  %6 = llvm.shl %5, %3 overflow<nsw,nuw> : i33
  %7 = llvm.lshr %5, %4 : i33
  %8 = llvm.or %6, %7 : i33
  %9 = llvm.trunc %8 : i33 to i9
  "llvm.return"(%9) : (i9) -> ()
}
]
set_option debug.skipKernelTC true in
theorem rotateleft_9_neg_mask_wide_amount_commute_proof : rotateleft_9_neg_mask_wide_amount_commute_before ⊑ rotateleft_9_neg_mask_wide_amount_commute_after := by
  unfold rotateleft_9_neg_mask_wide_amount_commute_before rotateleft_9_neg_mask_wide_amount_commute_after
  simp_alive_peephole
  intros
  ---BEGIN rotateleft_9_neg_mask_wide_amount_commute
  all_goals (try extract_goal ; sorry)
  ---END rotateleft_9_neg_mask_wide_amount_commute


