
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem and_orn_cmp_3_logical_thm.extracted_1._1 : ∀ (x x_1 : BitVec 72),
  ofBool (x <ᵤ x_1) = 1#1 →
    ofBool (x_1 ≤ᵤ x) = 1#1 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 1)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value 1#1) PoisonOr.poison :=
sorry