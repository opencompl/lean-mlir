
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem not_masked_sub_i8_thm.extracted_1._1 : ∀ (x : BitVec 8),
  True ∧ (11#8).ssubOverflow (x &&& 7#8) = true ∨ True ∧ (11#8).usubOverflow (x &&& 7#8) = true →
    HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
      @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
      (PoisonOr.value (11#8 - (x &&& 7#8))) PoisonOr.poison :=
sorry