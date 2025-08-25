
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem a_or_b_const2_thm.extracted_1._1 : ∀ (x x_1 x_2 x_3 : BitVec 32),
  ofBool (x_3 == x_2) &&& ofBool (x_1 != x) ||| ofBool (x_3 != x_2) &&& ofBool (x_1 == x) =
    ofBool (x_3 == x_2) ^^^ ofBool (x_1 == x) :=
sorry