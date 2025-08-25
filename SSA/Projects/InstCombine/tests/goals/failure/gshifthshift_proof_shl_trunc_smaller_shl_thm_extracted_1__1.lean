
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_trunc_smaller_shl_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(2#32 ≥ ↑32 ∨ 4#8 ≥ ↑8) →
    6#8 ≥ ↑8 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (truncate 8 (x <<< 2#32) <<< 4#8)) PoisonOr.poison :=
sorry