
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_and_ne_a_b_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8) (x_2 : BitVec 1),
  x_2 &&& ofBool (x_1 != x) = 1#1 → ¬x_2 = 1#1 → x_1 = x :=
sorry