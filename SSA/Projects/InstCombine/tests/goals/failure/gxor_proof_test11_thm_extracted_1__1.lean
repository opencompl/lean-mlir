
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test11_thm.extracted_1._1 : ∀ (x : BitVec 8),
  True ∧ (x &&& BitVec.ofInt 8 (-13) &&& 8#8 != 0) = true →
    HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
      @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
      (PoisonOr.value ((x ||| 12#8) ^^^ 4#8)) PoisonOr.poison :=
sorry