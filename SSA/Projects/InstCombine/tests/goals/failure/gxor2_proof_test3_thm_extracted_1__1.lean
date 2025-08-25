
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test3_thm.extracted_1._1 : ∀ (x : BitVec 32),
  True ∧ (x &&& 32#32 &&& 8#32 != 0) = true →
    HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
      @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
      (PoisonOr.value ((x ||| 145#32) &&& 177#32 ^^^ 153#32)) PoisonOr.poison :=
sorry