
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t5_thm.extracted_1._2 : ∀ (x : BitVec 1) (x_1 : BitVec 32),
  ¬(x = 1#1 ∨ x_1 ≥ ↑32) →
    ¬x = 1#1 →
      ¬1#32 <<< x_1 = 0 →
        x_1 ≥ ↑32 →
          HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
            @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
            (PoisonOr.value (x_1 / 1#32 <<< x_1)) PoisonOr.poison :=
sorry