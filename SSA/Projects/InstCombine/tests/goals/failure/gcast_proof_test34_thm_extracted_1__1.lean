
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test34_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬8#32 ≥ ↑32 →
    8#16 ≥ ↑16 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 16)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (truncate 16 (zeroExtend 32 x >>> 8#32))) PoisonOr.poison :=
sorry