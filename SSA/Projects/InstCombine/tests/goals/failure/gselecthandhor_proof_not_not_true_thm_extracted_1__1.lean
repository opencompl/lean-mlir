
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem not_not_true_thm.extracted_1._1 : ∀ (x : BitVec 1),
  ¬x ^^^ 1#1 = 1#1 →
    ¬x = 1#1 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 1)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value 1#1) PoisonOr.poison :=
sorry