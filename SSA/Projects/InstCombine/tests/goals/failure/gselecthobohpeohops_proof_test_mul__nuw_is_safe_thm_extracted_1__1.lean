
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_mul__nuw_is_safe_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 268435457#32 == 268435456#32) = 1#1 →
    True ∧ (x &&& 268435457#32).umulOverflow 9#32 = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (BitVec.ofInt 32 (-1879048192))) PoisonOr.poison :=
sorry