
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem udiv_mul_shl_nuw_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 5),
  ¬(True ∧ x_2.umulOverflow x_1 = true ∨ True ∧ x_2 <<< x >>> x ≠ x_2 ∨ x ≥ ↑5 ∨ x_2 <<< x = 0) →
    ¬x ≥ ↑5 → x_2 * x_1 / x_2 <<< x = x_1 >>> x :=
sorry