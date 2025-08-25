
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_thm.extracted_1._1 : ∀ (x x_1 : BitVec 16),
  True ∧ (signExtend 32 x_1).saddOverflow (signExtend 32 x) = true →
    HRefinement.IsRefinedBy (β := PoisonOr (BitVec 64)) (self :=
      @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
      (PoisonOr.value (signExtend 64 (signExtend 32 x_1 + signExtend 32 x))) PoisonOr.poison :=
sorry