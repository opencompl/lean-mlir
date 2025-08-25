
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test1_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x ^^^ 5#32 == 10#32) = 1#1 →
    ¬ofBool (x == 15#32) = 1#1 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 1)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value 1#1) PoisonOr.poison :=
sorry