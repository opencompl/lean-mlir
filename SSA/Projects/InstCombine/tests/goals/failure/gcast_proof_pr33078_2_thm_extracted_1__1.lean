
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem pr33078_2_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬4#16 ≥ ↑16 →
    4#8 ≥ ↑8 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 12)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (truncate 12 (signExtend 16 x >>> 4#16))) PoisonOr.poison :=
sorry