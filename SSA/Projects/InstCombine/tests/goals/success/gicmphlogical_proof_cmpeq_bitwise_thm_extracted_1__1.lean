
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem cmpeq_bitwise_thm.extracted_1._1 : ∀ (x x_1 x_2 x_3 : BitVec 8),
  ofBool (x_3 ^^^ x_2 ||| x_1 ^^^ x == 0#8) = ofBool (x_3 == x_2) &&& ofBool (x_1 == x) :=
sorry