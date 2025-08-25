
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test0_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 41),
  ¬(x_1 ≥ ↑41 ∨ x_1 ≥ ↑41) →
    x_1 ≥ ↑41 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 41)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (x_2 <<< x_1 &&& x <<< x_1)) PoisonOr.poison :=
sorry