
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t5_thm.extracted_1._6 : ∀ (x x_1 : BitVec 1) (x_2 : BitVec 32),
  x_1 = 1#1 →
    ¬x = 1#1 →
      ¬64#32 = 0 →
        6#32 ≥ ↑32 →
          HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
            @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
            (PoisonOr.value (x_2 / 64#32)) PoisonOr.poison :=
sorry