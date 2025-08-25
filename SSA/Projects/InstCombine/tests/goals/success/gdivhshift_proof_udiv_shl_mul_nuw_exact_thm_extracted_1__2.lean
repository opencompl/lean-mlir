
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem udiv_shl_mul_nuw_exact_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 5),
  ¬(True ∧ x_2 <<< x_1 >>> x_1 ≠ x_2 ∨
        x_1 ≥ ↑5 ∨ True ∧ x_2.umulOverflow x = true ∨ True ∧ (x_2 <<< x_1).umod (x_2 * x) ≠ 0 ∨ x_2 * x = 0) →
    ¬(True ∧ 1#5 <<< x_1 >>> x_1 ≠ 1#5 ∨ x_1 ≥ ↑5 ∨ True ∧ (1#5 <<< x_1).umod x ≠ 0 ∨ x = 0) →
      x_2 <<< x_1 / (x_2 * x) = 1#5 <<< x_1 / x :=
sorry