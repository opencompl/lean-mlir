
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_and1_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬ofBool (0#32 ≤ₛ x) = 1#1 →
    ofBool (-1#32 <ₛ x) = 1#1 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 1)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value 0#1) PoisonOr.poison :=
sorry