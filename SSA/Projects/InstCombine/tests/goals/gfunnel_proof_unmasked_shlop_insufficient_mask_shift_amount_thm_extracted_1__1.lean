
/-
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
-/

theorem unmasked_shlop_insufficient_mask_shift_amount_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 16),
  ¬(8#16 - (x_1 &&& 15#16) ≥ ↑16 ∨ x_1 &&& 15#16 ≥ ↑16) →
    True ∧ (8#16).ssubOverflow (x_1 &&& 15#16) = true ∨ 8#16 - (x_1 &&& 15#16) ≥ ↑16 ∨ x_1 &&& 15#16 ≥ ↑16 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
        @instHRefinementOfRefinement _
          (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
        (PoisonOr.value (truncate 8 (x_2 <<< (8#16 - (x_1 &&& 15#16)) ||| (x &&& 255#16) >>> (x_1 &&& 15#16))))
        PoisonOr.poison :=
sorry