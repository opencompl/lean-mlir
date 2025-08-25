
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem or_shl_thm.extracted_1._1 : ∀ (x x_1 x_2 x_3 : BitVec 8),
  ¬(x_2 ≥ ↑8 ∨ x_2 ≥ ↑8) →
    x_2 ≥ ↑8 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (x_3 <<< x_2 ||| x_1 ||| x <<< x_2)) PoisonOr.poison :=
sorry