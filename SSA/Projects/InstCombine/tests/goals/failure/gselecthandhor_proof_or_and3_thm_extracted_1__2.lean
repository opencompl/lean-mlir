
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem or_and3_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32) (x_2 : BitVec 1),
  x_2 ||| ofBool (x_1 == x) = 1#1 →
    ¬x_2 = 1#1 →
      ofBool (x_1 != x) = 1#1 →
        HRefinement.IsRefinedBy (β := PoisonOr (BitVec 1)) (self :=
          @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
          (PoisonOr.value x_2) PoisonOr.poison :=
sorry