
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem mul_selectp2_x_thm.extracted_1._3 : ∀ (x : BitVec 8) (x_1 : BitVec 1),
  ¬x_1 = 1#1 →
    2#8 ≥ ↑8 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (4#8 * x)) PoisonOr.poison :=
sorry