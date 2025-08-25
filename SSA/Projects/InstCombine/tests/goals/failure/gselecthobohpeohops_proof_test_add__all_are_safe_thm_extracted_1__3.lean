
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_add__all_are_safe_thm.extracted_1._3 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 1073741823#32 == 3#32) = 1#1 →
    True ∧ (x &&& 1073741823#32).saddOverflow 1#32 = true ∨ True ∧ (x &&& 1073741823#32).uaddOverflow 1#32 = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value ((x &&& 1073741823#32) + 1#32)) PoisonOr.poison :=
sorry