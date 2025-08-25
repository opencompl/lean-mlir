
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem basic_preserve_nuw_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ (x_1 ^^^ -1#8).uaddOverflow x = true) →
    True ∧ x_1.usubOverflow x = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value ((x_1 ^^^ -1#8) + x ^^^ -1#8)) PoisonOr.poison :=
sorry