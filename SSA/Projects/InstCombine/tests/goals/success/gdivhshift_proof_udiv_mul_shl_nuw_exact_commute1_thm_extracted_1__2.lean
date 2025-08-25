
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem udiv_mul_shl_nuw_exact_commute1_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 5),
  ¬(True ∧ x_2.umulOverflow x_1 = true ∨
        True ∧ x_1 <<< x >>> x ≠ x_1 ∨ x ≥ ↑5 ∨ True ∧ (x_2 * x_1).umod (x_1 <<< x) ≠ 0 ∨ x_1 <<< x = 0) →
    ¬(True ∧ x_2 >>> x <<< x ≠ x_2 ∨ x ≥ ↑5) → x_2 * x_1 / x_1 <<< x = x_2 >>> x :=
sorry