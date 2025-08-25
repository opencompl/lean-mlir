
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem main4f_like_logical_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 &&& x != x) = 1#1 →
    ofBool (x_1 &&& x == x) = 1#1 →
      ¬True →
        HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
          @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
          (PoisonOr.value 0#32) PoisonOr.poison :=
sorry