
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem trunc_lshr_exact_mask_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬2#8 ≥ ↑8 →
    2#6 ≥ ↑6 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 6)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (truncate 6 (x >>> 2#8) &&& 15#6)) PoisonOr.poison :=
sorry