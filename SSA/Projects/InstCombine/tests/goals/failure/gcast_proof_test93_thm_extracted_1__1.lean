
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test93_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬64#96 ≥ ↑96 →
    31#32 ≥ ↑32 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (truncate 32 (signExtend 96 x >>> 64#96))) PoisonOr.poison :=
sorry