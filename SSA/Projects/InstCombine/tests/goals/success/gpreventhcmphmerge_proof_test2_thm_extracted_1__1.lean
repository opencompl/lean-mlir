
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test2_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 ^^^ x == 0#32) ^^^ ofBool (x_1 ^^^ x == 32#32) = ofBool (x_1 == x) ^^^ ofBool (x_1 ^^^ x == 32#32) :=
sorry