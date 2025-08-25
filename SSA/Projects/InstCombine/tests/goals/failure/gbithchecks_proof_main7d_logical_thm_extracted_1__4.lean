
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem main7d_logical_thm.extracted_1._4 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 &&& (x_1 &&& x) == x_1 &&& x) = 1#1 →
    ¬ofBool (x_2 &&& (x_1 &&& x) != x_1 &&& x) = 1#1 →
      ¬0#1 = 1#1 →
        HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
          @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
          (PoisonOr.value 1#32) PoisonOr.poison :=
sorry