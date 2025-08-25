
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test4_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ x.uaddOverflow x = true) →
    True ∧ x <<< 1#32 >>> 1#32 ≠ x ∨ 1#32 ≥ ↑32 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 32)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (x + x)) PoisonOr.poison :=
sorry