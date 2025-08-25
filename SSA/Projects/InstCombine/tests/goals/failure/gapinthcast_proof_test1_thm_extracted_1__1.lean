
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test1_thm.extracted_1._1 : ∀ (x : BitVec 17),
  ¬(8#37 ≥ ↑37 ∨ 8#37 ≥ ↑37) →
    8#17 ≥ ↑17 ∨ 8#17 ≥ ↑17 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 17)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (truncate 17 (zeroExtend 37 x >>> 8#37 ||| zeroExtend 37 x <<< 8#37))) PoisonOr.poison :=
sorry