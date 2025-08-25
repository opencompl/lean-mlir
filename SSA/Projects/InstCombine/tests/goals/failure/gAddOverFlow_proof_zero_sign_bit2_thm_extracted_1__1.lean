
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem zero_sign_bit2_thm.extracted_1._1 : ∀ (x x_1 : BitVec 16),
  True ∧ (x_1 &&& 32767#16).uaddOverflow (x &&& 32767#16) = true →
    HRefinement.IsRefinedBy (β := PoisonOr (BitVec 16)) (self :=
      @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
      (PoisonOr.value ((x_1 &&& 32767#16) + (x &&& 32767#16))) PoisonOr.poison :=
sorry