
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_shl_constants_div_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(x ≥ ↑32 ∨ 2#32 ≥ ↑32 ∨ 1#32 <<< x <<< 2#32 = 0) →
    x + 2#32 ≥ ↑32 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (x_1 / 1#32 <<< x <<< 2#32)) PoisonOr.poison :=
sorry