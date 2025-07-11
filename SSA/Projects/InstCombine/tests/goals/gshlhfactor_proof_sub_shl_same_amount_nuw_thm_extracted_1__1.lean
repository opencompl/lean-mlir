 -- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

theorem sub_shl_same_amount_nuw_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 64),
  ¬(True ∧ x_2 <<< x_1 >>> x_1 ≠ x_2 ∨
        x_1 ≥ ↑64 ∨ True ∧ x <<< x_1 >>> x_1 ≠ x ∨ x_1 ≥ ↑64 ∨ True ∧ (x_2 <<< x_1).usubOverflow (x <<< x_1) = true) →
    True ∧ x_2.usubOverflow x = true ∨ True ∧ (x_2 - x) <<< x_1 >>> x_1 ≠ x_2 - x ∨ x_1 ≥ ↑64 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 64)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (x_2 <<< x_1 - x <<< x_1)) PoisonOr.poison :=
sorry