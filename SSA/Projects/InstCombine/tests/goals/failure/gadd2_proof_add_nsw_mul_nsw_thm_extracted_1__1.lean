
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem add_nsw_mul_nsw_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬(True ∧ x.saddOverflow x = true ∨ True ∧ (x + x).saddOverflow x = true) →
    True ∧ x.smulOverflow 3#16 = true →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 16)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (x + x + x)) PoisonOr.poison :=
sorry