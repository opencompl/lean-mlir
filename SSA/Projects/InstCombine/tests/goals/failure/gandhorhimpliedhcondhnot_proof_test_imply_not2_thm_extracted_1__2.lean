
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_imply_not2_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x == 0#32) = 1#1 →
    ¬ofBool (x != 0#32) = 1#1 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 1)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (0#1 ||| ofBool (x == 0#32) ^^^ 1#1)) PoisonOr.poison :=
sorry