
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem both_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬(x_1 ≥ ↑8 ∨ x ≥ ↑8) →
    ¬(True ∧ 1#8 <<< x >>> x ≠ 1#8 ∨ x ≥ ↑8 ∨ x_1 ≥ ↑8) →
      ofBool (1#8 <<< x <ᵤ 1#8 <<< x_1) = ofBool (1#8 <<< x >>> x_1 == 0#8) :=
sorry