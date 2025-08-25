
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_add_nsw__nuw_is_safe_thm.extracted_1._3 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 2147483647#32 == 2147483647#32) = 1#1 →
    ¬(True ∧ (x &&& 2147483647#32).saddOverflow 1#32 = true) →
      True ∧ (x &&& 2147483647#32).uaddOverflow 1#32 = true →
        HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
          @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
          (PoisonOr.value ((x &&& 2147483647#32) + 1#32)) PoisonOr.poison :=
sorry