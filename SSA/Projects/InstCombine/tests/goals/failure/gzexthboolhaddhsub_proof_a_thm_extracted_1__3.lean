
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem a_thm.extracted_1._3 : ∀ (x x_1 : BitVec 1),
  ¬x_1 = 1#1 →
    True ∧ (1#32).saddOverflow (signExtend 32 x) = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (zeroExtend 32 x_1 + 1#32 + (0#32 - zeroExtend 32 x))) PoisonOr.poison :=
sorry