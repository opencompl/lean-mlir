
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_sub_nsw__nsw_is_safe_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x ||| BitVec.ofInt 32 (-2147483648) == BitVec.ofInt 32 (-2147483647)) = 1#1 →
    True ∧ (BitVec.ofInt 32 (-2147483648)).ssubOverflow (x ||| BitVec.ofInt 32 (-2147483648)) = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (-1#32)) PoisonOr.poison :=
sorry