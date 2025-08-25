
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_xor_xor_bad_mask_distribute_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(1#8 ≥ ↑8 ∨ 1#8 ≥ ↑8) →
    1#8 ≥ ↑8 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (x_1 <<< 1#8 ^^^ (x <<< 1#8 ^^^ BitVec.ofInt 8 (-68)))) PoisonOr.poison :=
sorry