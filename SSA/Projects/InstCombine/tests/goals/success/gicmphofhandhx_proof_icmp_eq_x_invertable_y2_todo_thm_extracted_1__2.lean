
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_eq_x_invertable_y2_todo_thm.extracted_1._2 : ∀ (x : BitVec 8) (x_1 : BitVec 1),
  ¬x_1 = 1#1 → ofBool (24#8 == x &&& 24#8) = ofBool (x ||| BitVec.ofInt 8 (-25) == -1#8) :=
sorry