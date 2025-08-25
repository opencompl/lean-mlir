
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem multiuse_lshr_lshr_thm.extracted_1._1 : ∀ (x : BitVec 9),
  ¬(2#9 ≥ ↑9 ∨ 2#9 ≥ ↑9 ∨ 3#9 ≥ ↑9) →
    2#9 ≥ ↑9 ∨ 5#9 ≥ ↑9 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 9)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (x >>> 2#9 * x >>> 2#9 >>> 3#9)) PoisonOr.poison :=
sorry