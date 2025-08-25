
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_mul_nuw__nsw_is_safe_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x ||| BitVec.ofInt 32 (-83886080) == BitVec.ofInt 32 (-83886079)) = 1#1 →
    True ∧ (x ||| BitVec.ofInt 32 (-83886080)).smulOverflow 9#32 = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (BitVec.ofInt 32 (-754974711))) PoisonOr.poison :=
sorry