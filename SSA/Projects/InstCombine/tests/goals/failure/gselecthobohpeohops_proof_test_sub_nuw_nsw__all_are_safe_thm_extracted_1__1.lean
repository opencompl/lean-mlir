
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_sub_nuw_nsw__all_are_safe_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 255#32 == 6#32) = 1#1 →
    True ∧ (BitVec.ofInt 32 (-254)).ssubOverflow (x &&& 255#32) = true ∨
        True ∧ (BitVec.ofInt 32 (-254)).usubOverflow (x &&& 255#32) = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (BitVec.ofInt 32 (-260))) PoisonOr.poison :=
sorry