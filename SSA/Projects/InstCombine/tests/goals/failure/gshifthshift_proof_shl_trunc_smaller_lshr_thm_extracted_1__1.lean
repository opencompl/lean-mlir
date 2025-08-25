
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_trunc_smaller_lshr_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(3#32 ≥ ↑32 ∨ 5#8 ≥ ↑8) →
    2#8 ≥ ↑8 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (truncate 8 (x >>> 3#32) <<< 5#8)) PoisonOr.poison :=
sorry