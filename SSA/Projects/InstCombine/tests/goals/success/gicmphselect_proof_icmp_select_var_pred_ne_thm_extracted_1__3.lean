
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_select_var_pred_ne_thm.extracted_1._3 : ∀ (x x_1 x_2 : BitVec 8),
  ofBool (x_2 == 0#8) = 1#1 → ofBool (x_2 != 0#8) = 1#1 → ofBool (x_1 != x_1) = ofBool (x != x_1) :=
sorry