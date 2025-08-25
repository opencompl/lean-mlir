
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem reused_mul_nuw_xy_z_selectnonzero_ugt_thm.extracted_1._6 : ∀ (x x_1 x_2 : BitVec 8),
  ¬ofBool (x_2 != 0#8) = 1#1 →
    ¬ofBool (x_2 == 0#8) = 1#1 → True ∧ x_1.umulOverflow x_2 = true ∨ True ∧ x.umulOverflow x_2 = true → False :=
sorry