
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem a_or_b_const_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 == x_1) &&& ofBool (x != x_1) ||| ofBool (x_2 != x_1) &&& ofBool (x == x_1) =
    ofBool (x_2 == x_1) ^^^ ofBool (x == x_1) :=
sorry