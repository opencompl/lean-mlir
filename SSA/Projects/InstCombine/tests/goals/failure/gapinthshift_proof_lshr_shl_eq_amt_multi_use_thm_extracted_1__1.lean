
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_shl_eq_amt_multi_use_thm.extracted_1._1 : ∀ (x : BitVec 43),
  ¬(23#43 ≥ ↑43 ∨ 23#43 ≥ ↑43 ∨ 23#43 ≥ ↑43) →
    23#43 ≥ ↑43 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 43)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (x >>> 23#43 * x >>> 23#43 <<< 23#43)) PoisonOr.poison :=
sorry