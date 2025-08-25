
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_and_xor_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(1#8 ≥ ↑8 ∨ 1#8 ≥ ↑8) →
    1#8 ≥ ↑8 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (x_1 <<< 1#8 ^^^ x <<< 1#8 &&& 20#8)) PoisonOr.poison :=
sorry