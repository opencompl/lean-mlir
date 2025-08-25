
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem positive_biggerShl_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(10#32 ≥ ↑32 ∨ 5#32 ≥ ↑32) →
    5#32 ≥ ↑32 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (x <<< 10#32 >>> 5#32)) PoisonOr.poison :=
sorry