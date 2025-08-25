
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_nuw_eq_0_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ x_1 <<< x >>> x ≠ x_1 ∨ x ≥ ↑8) → ofBool (x_1 <<< x == 0#8) = ofBool (x_1 == 0#8) :=
sorry