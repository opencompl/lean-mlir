
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem pr33078_1_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬8#16 ≥ ↑16 →
    7#8 ≥ ↑8 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (truncate 8 (signExtend 16 x >>> 8#16))) PoisonOr.poison :=
sorry