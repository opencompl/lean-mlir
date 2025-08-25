
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem positive_samevar_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(x ≥ ↑32 ∨ x ≥ ↑32) →
    x ≥ ↑32 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (x_1 <<< x >>> x)) PoisonOr.poison :=
sorry