
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sub_shl_same_amount_nuw_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 64),
  ¬(True ∧ x_2 <<< x_1 >>> x_1 ≠ x_2 ∨
        x_1 ≥ ↑64 ∨ True ∧ x <<< x_1 >>> x_1 ≠ x ∨ x_1 ≥ ↑64 ∨ True ∧ (x_2 <<< x_1).usubOverflow (x <<< x_1) = true) →
    True ∧ x_2.usubOverflow x = true ∨ True ∧ (x_2 - x) <<< x_1 >>> x_1 ≠ x_2 - x ∨ x_1 ≥ ↑64 → False :=
sorry