
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem positive_with_extra_and_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(ofBool (x + 128#32 <ᵤ 256#32) = 1#1 ∧ ofBool (-1#32 <ₛ x) = 1#1) →
    ofBool (x <ᵤ 128#32) = 1#1 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 1)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value 0#1) PoisonOr.poison :=
sorry