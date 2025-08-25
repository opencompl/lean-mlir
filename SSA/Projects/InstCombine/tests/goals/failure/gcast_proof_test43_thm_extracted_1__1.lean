
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test43_thm.extracted_1._1 : ∀ (x : BitVec 8),
  True ∧ (zeroExtend 32 x).saddOverflow (-1#32) = true →
    HRefinement.IsRefinedBy (β := PoisonOr (BitVec 64)) (self :=
      @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
      (PoisonOr.value (signExtend 64 (zeroExtend 32 x + -1#32))) PoisonOr.poison :=
sorry