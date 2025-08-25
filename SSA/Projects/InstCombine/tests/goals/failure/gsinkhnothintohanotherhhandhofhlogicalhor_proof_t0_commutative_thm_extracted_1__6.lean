
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t0_commutative_thm.extracted_1._6 : ∀ (x : BitVec 8) (x_1 : BitVec 1) (x_2 x_3 : BitVec 8),
  ofBool (x_3 == x_2) = 1#1 →
    ofBool (x_3 != x_2) = 1#1 →
      ¬True →
        x_1 = 1#1 →
          HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
            @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
            (PoisonOr.value x) PoisonOr.poison :=
sorry