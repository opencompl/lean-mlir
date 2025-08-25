
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_sub_i8_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬7#8 - x ≥ ↑8 →
    True ∧ BitVec.ofInt 8 (-128) >>> x <<< x ≠ BitVec.ofInt 8 (-128) ∨ x ≥ ↑8 →
      HRefinement.IsRefinedBy (β := PoisonOr (BitVec 8)) (self :=
        @PoisonOr.instHRefinement _ _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec))
        (PoisonOr.value (1#8 <<< (7#8 - x))) PoisonOr.poison :=
sorry