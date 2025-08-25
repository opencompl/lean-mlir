
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_lshr_exact_lshr_only_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (-1#32 <ₛ x_1) = 1#1 →
    ¬(True ∧ x_1 >>> x <<< x ≠ x_1 ∨ x ≥ ↑32) →
      x ≥ ↑32 →
        HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
          @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
          (PoisonOr.value (x_1 >>> x)) PoisonOr.poison :=
sorry