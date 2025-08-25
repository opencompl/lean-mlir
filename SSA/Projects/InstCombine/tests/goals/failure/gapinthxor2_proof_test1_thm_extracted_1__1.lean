
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test1_thm.extracted_1._1 : ∀ (x x_1 : BitVec 447),
  True ∧ (x_1 &&& 70368744177664#447 &&& (x &&& 70368744177663#447) != 0) = true →
    HRefinement.IsRefinedBy (β := PoisonOr (BitVec 447)) (self :=
      @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
      (PoisonOr.value (x_1 &&& 70368744177664#447 ^^^ x &&& 70368744177663#447)) PoisonOr.poison :=
sorry