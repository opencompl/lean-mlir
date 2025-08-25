
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_or_or_fail_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(5#8 ≥ ↑8 ∨ 5#8 ≥ ↑8) →
    5#8 ≥ ↑8 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (x_1 >>> 5#8 ||| (x >>> 5#8 ||| BitVec.ofInt 8 (-58)))) PoisonOr.poison :=
sorry