
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem n1_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬x_1 ≥ ↑8 →
    True ∧ 1#8 <<< x_1 >>> x_1 ≠ 1#8 ∨ x_1 ≥ ↑8 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 1)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (ofBool ((1#8 <<< x_1 ^^^ -1#8) &&& x != x))) PoisonOr.poison :=
sorry