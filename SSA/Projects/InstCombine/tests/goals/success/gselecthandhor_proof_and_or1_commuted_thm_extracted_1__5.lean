
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem and_or1_commuted_thm.extracted_1._5 : ∀ (x x_1 x_2 : BitVec 1),
  x_2 ||| x_1 ^^^ 1#1 = 1#1 → x_1 = 1#1 → ¬x_2 = 1#1 → x_1 = x :=
sorry