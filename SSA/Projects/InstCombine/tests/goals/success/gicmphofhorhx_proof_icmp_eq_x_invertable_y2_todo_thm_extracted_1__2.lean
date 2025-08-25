
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_eq_x_invertable_y2_todo_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8) (x_2 : BitVec 1),
  x_2 = 1#1 → ofBool (7#8 == x ||| 7#8) = ofBool (x &&& BitVec.ofInt 8 (-8) == 0#8) :=
sorry