
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem bools2_logical_commute1_and2_thm.extracted_1._5 : ∀ (x x_1 : BitVec 1),
  ¬x_1 = 1#1 →
    0#1 = 1#1 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 1)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value 1#1) PoisonOr.poison :=
sorry