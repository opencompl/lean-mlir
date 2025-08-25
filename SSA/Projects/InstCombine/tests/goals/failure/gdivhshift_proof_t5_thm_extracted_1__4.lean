
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t5_thm.extracted_1._4 : ∀ (x x_1 : BitVec 1) (x_2 : BitVec 32),
  x_1 = 1#1 →
    x = 1#1 →
      ¬32#32 = 0 →
        5#32 ≥ ↑32 →
          HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
            @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
            (PoisonOr.value (x_2 / 32#32)) PoisonOr.poison :=
sorry