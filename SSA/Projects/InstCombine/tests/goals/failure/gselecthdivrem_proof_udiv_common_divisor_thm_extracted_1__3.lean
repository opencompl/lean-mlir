
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem udiv_common_divisor_thm.extracted_1._3 : ∀ (x x_1 : BitVec 5) (x_2 : BitVec 1),
  ¬(x_2 = 1#1 ∨ x_1 = 0) →
    ¬x_2 = 1#1 →
      x_1 = 0 →
        HRefinement.IsRefinedBy (β := PoisonOr (BitVec 5)) (self :=
          @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
          (PoisonOr.value (x / x_1)) PoisonOr.poison :=
sorry