
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem trunc_shl_lshr_infloop_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬(1#64 ≥ ↑64 ∨ 2#64 ≥ ↑64) →
    1#32 ≥ ↑32 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (truncate 32 (x >>> 1#64 <<< 2#64))) PoisonOr.poison :=
sorry