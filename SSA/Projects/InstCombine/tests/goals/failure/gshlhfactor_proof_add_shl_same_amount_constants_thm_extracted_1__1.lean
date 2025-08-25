
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem add_shl_same_amount_constants_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(x ≥ ↑8 ∨ x ≥ ↑8) →
    x ≥ ↑8 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (4#8 <<< x + 3#8 <<< x)) PoisonOr.poison :=
sorry