
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem add_shl_same_amount_nuw_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 64),
  ¬(True ∧ x_2 <<< x_1 >>> x_1 ≠ x_2 ∨
        x_1 ≥ ↑64 ∨ True ∧ x <<< x_1 >>> x_1 ≠ x ∨ x_1 ≥ ↑64 ∨ True ∧ (x_2 <<< x_1).uaddOverflow (x <<< x_1) = true) →
    ¬(True ∧ x_2.uaddOverflow x = true ∨ True ∧ (x_2 + x) <<< x_1 >>> x_1 ≠ x_2 + x ∨ x_1 ≥ ↑64) →
      x_2 <<< x_1 + x <<< x_1 = (x_2 + x) <<< x_1 :=
sorry