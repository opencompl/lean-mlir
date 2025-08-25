
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_logical_or_eq_a_b_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8) (x_2 : BitVec 1),
  ¬x_2 = 1#1 → ofBool (x_1 == x) = 1#1 → x_1 = x :=
sorry