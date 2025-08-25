
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem uaddo_wrong_pred2_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x ^^^ -1#32 ≤ᵤ x_1) = 1#1 →
    ¬ofBool (x_1 <ᵤ x ^^^ -1#32) = 1#1 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (x_1 + x)) PoisonOr.poison :=
sorry