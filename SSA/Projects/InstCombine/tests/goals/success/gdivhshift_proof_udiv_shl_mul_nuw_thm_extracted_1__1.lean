
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem udiv_shl_mul_nuw_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 5),
  ¬(True ∧ x_2 <<< x_1 >>> x_1 ≠ x_2 ∨ x_1 ≥ ↑5 ∨ True ∧ x_2.umulOverflow x = true ∨ x_2 * x = 0) →
    True ∧ 1#5 <<< x_1 >>> x_1 ≠ 1#5 ∨ x_1 ≥ ↑5 ∨ x = 0 → False :=
sorry