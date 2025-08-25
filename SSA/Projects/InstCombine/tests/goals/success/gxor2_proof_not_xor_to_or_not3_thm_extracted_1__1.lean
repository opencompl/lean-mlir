
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem not_xor_to_or_not3_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 3),
  x_2 &&& x_1 ^^^ (x_2 ||| x) ^^^ -1#3 = x_2 &&& x_1 ||| (x_2 ||| x) ^^^ -1#3 :=
sorry