
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_mul_negative_nonuw_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬2#64 ≥ ↑64 →
    True ∧ (x * 52#64) >>> 2#64 <<< 2#64 ≠ x * 52#64 ∨ 2#64 ≥ ↑64 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 64)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value ((x * 52#64) >>> 2#64)) PoisonOr.poison :=
sorry