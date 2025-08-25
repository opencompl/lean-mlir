
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem udiv_shl_mul_nuw_swap_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 5),
  ¬(True ∧ x_2 <<< x_1 >>> x_1 ≠ x_2 ∨ x_1 ≥ ↑5 ∨ True ∧ x.umulOverflow x_2 = true ∨ x * x_2 = 0) →
    ¬(True ∧ 1#5 <<< x_1 >>> x_1 ≠ 1#5 ∨ x_1 ≥ ↑5 ∨ x = 0) → x_2 <<< x_1 / (x * x_2) = 1#5 <<< x_1 / x :=
sorry