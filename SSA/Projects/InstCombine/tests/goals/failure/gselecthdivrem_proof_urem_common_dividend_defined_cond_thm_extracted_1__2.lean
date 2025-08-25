
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem urem_common_dividend_defined_cond_thm.extracted_1._2 : ∀ (x x_1 : BitVec 5) (x_2 : BitVec 1),
  ¬(x_2 = 1#1 ∨ x = 0) →
    ¬x_2 = 1#1 →
      x = 0 →
        HRefinement.IsRefinedBy (β := PoisonOr (BitVec 5)) (self :=
          @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
          (PoisonOr.value (x_1 % x)) PoisonOr.poison :=
sorry