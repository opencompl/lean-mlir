
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_eq_x_invertable_y_todo_thm.extracted_1._1 : ∀ (x : BitVec 1) (x_1 : BitVec 8),
  x = 1#1 → ofBool (x_1 == x_1 &&& 7#8) = ofBool (x_1 &&& BitVec.ofInt 8 (-8) == 0#8) :=
sorry