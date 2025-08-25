
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem bools_multi_uses2_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 1),
  ¬x_2 = 1#1 → ((x_2 ^^^ 1#1) &&& x_1 ||| x_2 &&& x) &&& ((x_2 ^^^ 1#1) &&& x_1) + (x_2 &&& x) = x_1 :=
sorry