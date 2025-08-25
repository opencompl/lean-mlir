
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem trunc_lshr_trunc_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬8#32 ≥ ↑32 →
    8#64 ≥ ↑64 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (truncate 8 (truncate 32 x >>> 8#32))) PoisonOr.poison :=
sorry