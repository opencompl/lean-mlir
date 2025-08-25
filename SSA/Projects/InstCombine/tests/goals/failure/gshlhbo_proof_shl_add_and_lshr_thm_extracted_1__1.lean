
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_add_and_lshr_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(4#32 ≥ ↑32 ∨ 4#32 ≥ ↑32) →
    4#32 ≥ ↑32 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (((x_1 >>> 4#32 &&& 8#32) + x) <<< 4#32)) PoisonOr.poison :=
sorry