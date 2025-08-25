
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_xor_ne_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 8),
  ofBool (x_2 ^^^ -1#8 != x_1 ^^^ -1#8 ^^^ x) = ofBool (x_2 != x_1 ^^^ x) :=
sorry