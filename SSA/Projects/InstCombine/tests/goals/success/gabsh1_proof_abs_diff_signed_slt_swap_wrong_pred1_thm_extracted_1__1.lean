
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem abs_diff_signed_slt_swap_wrong_pred1_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 == x) = 1#1 → ¬(True ∧ x.ssubOverflow x_1 = true) → True ∧ x_1.ssubOverflow x = true → False :=
sorry