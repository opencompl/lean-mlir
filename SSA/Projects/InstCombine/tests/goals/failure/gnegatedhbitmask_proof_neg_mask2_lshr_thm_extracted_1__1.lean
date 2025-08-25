
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem neg_mask2_lshr_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬3#8 ≥ ↑8 →
    3#8 ≥ ↑8 ∨ True ∧ (0#8).ssubOverflow (x >>> 3#8 &&& 2#8) = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (0#8 - (x >>> 3#8 &&& 2#8))) PoisonOr.poison :=
sorry