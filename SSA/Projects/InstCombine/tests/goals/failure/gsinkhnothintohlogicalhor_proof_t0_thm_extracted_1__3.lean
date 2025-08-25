
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t0_thm.extracted_1._3 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 == x_1) = 1#1 →
    ofBool (x_2 != x_1) = 1#1 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 1)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (1#1 ^^^ 1#1)) PoisonOr.poison :=
sorry