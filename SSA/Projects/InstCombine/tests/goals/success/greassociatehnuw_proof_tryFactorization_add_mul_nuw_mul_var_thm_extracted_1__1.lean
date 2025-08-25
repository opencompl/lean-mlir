
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem tryFactorization_add_mul_nuw_mul_var_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 32),
  ¬(True ∧ x_2.umulOverflow x_1 = true ∨ True ∧ x_2.umulOverflow x = true) → x_2 * x_1 + x_2 * x = x_2 * (x_1 + x) :=
sorry