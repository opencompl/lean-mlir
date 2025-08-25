
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem bools_logical_commute1_and2_thm.extracted_1._10 : ∀ (x x_1 x_2 : BitVec 1),
  x_2 = 1#1 → ¬x_1 = 1#1 → ¬x_1 ^^^ 1#1 = 1#1 → x_1 &&& x = x_2 :=
sorry