
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem or_and3_commuted_thm.extracted_1._2 : ∀ (x : BitVec 1) (x_1 x_2 : BitVec 32),
  ofBool (x_2 == x_1) ||| x = 1#1 →
    ¬x = 1#1 →
      ofBool (x_2 != x_1) = 1#1 →
        HRefinement.IsRefinedBy (β := PoisonOr (BitVec 1)) (self :=
          @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
          (PoisonOr.value x) PoisonOr.poison :=
sorry