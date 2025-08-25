
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬x ≥ ↑32 →
    True ∧ 1#32 <<< x >>> x ≠ 1#32 ∨ x ≥ ↑32 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 1)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (ofBool (3968#32 >>> x &&& 1#32 == 0#32))) PoisonOr.poison :=
sorry