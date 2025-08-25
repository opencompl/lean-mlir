
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem negative_and_odd_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬((2#32 == 0 || 32 != 1 && x == intMin 32 && 2#32 == -1) = true ∨ 31#32 ≥ ↑32) →
    31#32 ≥ ↑32 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (x.srem 2#32 >>> 31#32)) PoisonOr.poison :=
sorry