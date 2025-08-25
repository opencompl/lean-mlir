
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_select_var_commuted_thm.extracted_1._3 : ∀ (x x_1 x_2 : BitVec 8),
  ¬x_2 = 0 → ¬ofBool (x_1 == 0#8) = 1#1 → ofBool (42#8 / x_2 == x) = ofBool (x == 42#8 / x_2) :=
sorry