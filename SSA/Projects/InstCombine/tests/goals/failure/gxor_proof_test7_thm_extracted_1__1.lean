
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test7_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  True ∧ (x_1 &&& 7#32 &&& (x &&& 128#32) != 0) = true →
    HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
      @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
      (PoisonOr.value (x_1 &&& 7#32 ^^^ x &&& 128#32)) PoisonOr.poison :=
sorry