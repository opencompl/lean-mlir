
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_trunc_bigger_lshr_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(5#32 ≥ ↑32 ∨ 3#8 ≥ ↑8) →
    2#32 ≥ ↑32 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (truncate 8 (x >>> 5#32) <<< 3#8)) PoisonOr.poison :=
sorry