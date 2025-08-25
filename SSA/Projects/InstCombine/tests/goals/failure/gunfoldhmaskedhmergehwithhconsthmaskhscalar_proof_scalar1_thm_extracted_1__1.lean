
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem scalar1_thm.extracted_1._1 : ∀ (x x_1 : BitVec 4),
  True ∧ (x_1 &&& BitVec.ofInt 4 (-2) &&& (x &&& 1#4) != 0) = true →
    HRefinement.IsRefinedBy (β := PoisonOr (BitVec 4)) (self :=
      @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
      (PoisonOr.value ((x_1 ^^^ x) &&& BitVec.ofInt 4 (-2) ^^^ x)) PoisonOr.poison :=
sorry