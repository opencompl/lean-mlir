
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_thm.extracted_1._3 : ∀ (x : BitVec 1) (x_1 : BitVec 32),
  ¬x = 1#1 →
    ¬1#32 = 0 →
      0#32 ≥ ↑32 →
        HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
          @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
          (PoisonOr.value (x_1 / 1#32)) PoisonOr.poison :=
sorry