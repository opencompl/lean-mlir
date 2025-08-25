
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem not_logicalAnd_not_op1_thm.extracted_1._2 : ∀ (x : BitVec 1),
  ¬x = 1#1 →
    ¬x ^^^ 1#1 = 1#1 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 1)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (0#1 ^^^ 1#1)) PoisonOr.poison :=
sorry