
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem PR96857_xor_without_noundef_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 4),
  x_2 &&& x_1 ^^^ (x_2 ^^^ -1#4) &&& x = x_2 &&& x_1 ||| x &&& (x_2 ^^^ -1#4) :=
sorry