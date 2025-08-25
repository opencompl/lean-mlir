
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_select_var_commuted_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 8),
  ¬x_2 = 0 → ofBool (x_1 == 0#8) = 1#1 → ofBool (42#8 / x_2 == 42#8 / x_2) = 1#1 :=
sorry