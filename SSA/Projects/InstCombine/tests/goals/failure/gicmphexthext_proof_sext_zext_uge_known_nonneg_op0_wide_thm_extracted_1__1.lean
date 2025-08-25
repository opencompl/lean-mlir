
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sext_zext_uge_known_nonneg_op0_wide_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 16),
  True ∧ (x &&& 12#8).msb = true →
    HRefinement.IsRefinedBy (β := PoisonOr (BitVec 1)) (self :=
      @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
      (PoisonOr.value (ofBool (zeroExtend 32 (x &&& 12#8) ≤ᵤ signExtend 32 x_1))) PoisonOr.poison :=
sorry