
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_or_eq_different_operands_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 8),
  ofBool (x_2 == x_1) ||| ofBool (x == x_2) = 1#1 → ¬ofBool (x_2 == x_1) = 1#1 → x_2 = x :=
sorry