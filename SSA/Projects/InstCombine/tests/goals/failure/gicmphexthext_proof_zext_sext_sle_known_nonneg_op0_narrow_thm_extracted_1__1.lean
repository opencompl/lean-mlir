
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem zext_sext_sle_known_nonneg_op0_narrow_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 8),
  True ∧ (x_1 &&& 12#8).msb = true →
    HRefinement.IsRefinedBy (β := PoisonOr (BitVec 1)) (self :=
      @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
      (PoisonOr.value (ofBool (zeroExtend 32 (x_1 &&& 12#8) ≤ₛ signExtend 32 x))) PoisonOr.poison :=
sorry