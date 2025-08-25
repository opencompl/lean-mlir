
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test82_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬(8#32 ≥ ↑32 ∨ 9#32 ≥ ↑32) →
    1#32 ≥ ↑32 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 64)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (zeroExtend 64 (truncate 32 x >>> 8#32 <<< 9#32))) PoisonOr.poison :=
sorry