
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_add_nuw_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ x.uaddOverflow 5#32 = true ∨ x + 5#32 ≥ ↑32) →
    x ≥ ↑32 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (6#32 <<< (x + 5#32))) PoisonOr.poison :=
sorry