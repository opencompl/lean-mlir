
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_ne_0_and_15_add_3_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (x + 3#8 &&& 15#8 != 0#8) = ofBool (x &&& 15#8 != 13#8) :=
sorry