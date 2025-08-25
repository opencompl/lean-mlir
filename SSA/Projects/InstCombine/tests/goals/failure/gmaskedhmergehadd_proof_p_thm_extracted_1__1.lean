
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem p_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 32),
  True ∧ (x_2 &&& x_1 &&& (x &&& (x_1 ^^^ -1#32)) != 0) = true →
    HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
      @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
      (PoisonOr.value ((x_2 &&& x_1) + ((x_1 ^^^ -1#32) &&& x))) PoisonOr.poison :=
sorry