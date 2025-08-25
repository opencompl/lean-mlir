
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem mul_x_selectp2_thm.extracted_1._3 : ∀ (x : BitVec 1) (x_1 : BitVec 8),
  ¬x = 1#1 →
    0#8 ≥ ↑8 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (x_1 * x_1 * 1#8)) PoisonOr.poison :=
sorry