
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_ne_11_and_15_add_10_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (x + 10#8 &&& 15#8 != 11#8) = ofBool (x &&& 15#8 != 1#8) :=
sorry