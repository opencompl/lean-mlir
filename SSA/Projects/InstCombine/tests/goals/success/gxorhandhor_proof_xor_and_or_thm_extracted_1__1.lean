
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem xor_and_or_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 1),
  x_2 = 1#1 → x_2 &&& x_1 ^^^ (x ||| x_2) = x_1 ^^^ 1#1 :=
sorry