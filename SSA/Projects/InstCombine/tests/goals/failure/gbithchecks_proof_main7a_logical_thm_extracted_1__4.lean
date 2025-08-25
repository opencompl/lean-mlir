
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem main7a_logical_thm.extracted_1._4 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 &&& x == x_1) = 1#1 →
    ¬ofBool (x_1 &&& x != x_1) = 1#1 →
      ¬0#1 = 1#1 →
        HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
          @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
          (PoisonOr.value 1#32) PoisonOr.poison :=
sorry