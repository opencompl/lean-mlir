
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem bar_thm.extracted_1._1 : ∀ (x x_1 : BitVec 64),
  ofBool (x_1 &&& (x_1 &&& x ^^^ -1#64) == 0#64) = ofBool (x_1 &&& (x ^^^ -1#64) == 0#64) :=
sorry