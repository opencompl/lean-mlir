
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_eq_x_invertable_y2_todo_thm.extracted_1._3 : ∀ (x x_1 : BitVec 8) (x_2 : BitVec 1),
  ¬x_2 = 1#1 → ofBool (x_1 ^^^ -1#8 == x ||| x_1 ^^^ -1#8) = ofBool (x &&& x_1 == 0#8) :=
sorry