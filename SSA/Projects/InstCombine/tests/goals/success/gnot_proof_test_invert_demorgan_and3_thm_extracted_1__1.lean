
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_invert_demorgan_and3_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 + (x ^^^ -1#32) &&& 4095#32 == 0#32) = ofBool (x - x_1 &&& 4095#32 == 4095#32) :=
sorry