
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem multiuse_shl_shl_thm.extracted_1._1 : ∀ (x : BitVec 42),
  ¬(8#42 ≥ ↑42 ∨ 8#42 ≥ ↑42 ∨ 9#42 ≥ ↑42) →
    8#42 ≥ ↑42 ∨ 17#42 ≥ ↑42 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 42)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (x <<< 8#42 * x <<< 8#42 <<< 9#42)) PoisonOr.poison :=
sorry