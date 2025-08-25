
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_sext3_thm.extracted_1._1 : ∀ (x : BitVec 1),
  x = 1#1 →
    x ^^^ 1#1 = 1#1 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value 0#32) PoisonOr.poison :=
sorry