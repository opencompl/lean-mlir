
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_mul_nsw__all_are_safe_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 255#32 == 17#32) = 1#1 →
    True ∧ (x &&& 255#32).smulOverflow 9#32 = true ∨ True ∧ (x &&& 255#32).umulOverflow 9#32 = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value 153#32) PoisonOr.poison :=
sorry