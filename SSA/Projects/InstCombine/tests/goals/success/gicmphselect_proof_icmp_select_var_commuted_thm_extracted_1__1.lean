
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_select_var_commuted_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬x_1 = 0 → ofBool (x == 0#8) = 1#1 → ofBool (42#8 / x_1 == 42#8 / x_1) = 1#1 :=
sorry