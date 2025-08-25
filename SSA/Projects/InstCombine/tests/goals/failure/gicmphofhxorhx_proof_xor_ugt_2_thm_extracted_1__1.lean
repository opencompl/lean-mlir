
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem xor_ugt_2_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 8),
  True ∧ (x &&& 63#8 &&& 64#8 != 0) = true →
    HRefinement.IsRefinedBy (β := PoisonOr (BitVec 1)) (self :=
      @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
      (PoisonOr.value (ofBool (x_2 + x_1 ^^^ (x &&& 63#8 ||| 64#8) <ᵤ x_2 + x_1))) PoisonOr.poison :=
sorry