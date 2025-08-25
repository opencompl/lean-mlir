
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_xor_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(5#32 ≥ ↑32 ∨ 7#32 ≥ ↑32) →
    12#32 ≥ ↑32 ∨ 7#32 ≥ ↑32 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value ((x_1 <<< 5#32 ^^^ x) <<< 7#32)) PoisonOr.poison :=
sorry