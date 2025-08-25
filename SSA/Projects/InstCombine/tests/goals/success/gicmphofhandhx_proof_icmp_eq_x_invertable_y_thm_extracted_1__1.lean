
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_eq_x_invertable_y_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool (x_1 == x_1 &&& (x ^^^ -1#8)) = ofBool (x_1 &&& x == 0#8) :=
sorry