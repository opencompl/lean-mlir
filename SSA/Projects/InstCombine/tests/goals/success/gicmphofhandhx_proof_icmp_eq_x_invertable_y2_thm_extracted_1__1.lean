
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_eq_x_invertable_y2_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool (x_1 ^^^ -1#8 == x &&& (x_1 ^^^ -1#8)) = ofBool (x ||| x_1 == -1#8) :=
sorry