
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test13_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(8#32 ≥ ↑32 ∨ 8#32 ≥ ↑32) →
    8#32 ≥ ↑32 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value ((x_1 - x <<< 8#32 &&& 128#32) * x <<< 8#32)) PoisonOr.poison :=
sorry