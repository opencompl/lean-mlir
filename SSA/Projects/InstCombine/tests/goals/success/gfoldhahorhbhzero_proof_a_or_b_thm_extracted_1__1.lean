
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem a_or_b_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 == 0#32) &&& ofBool (x != 0#32) ||| ofBool (x_1 != 0#32) &&& ofBool (x == 0#32) =
    ofBool (x_1 == 0#32) ^^^ ofBool (x == 0#32) :=
sorry