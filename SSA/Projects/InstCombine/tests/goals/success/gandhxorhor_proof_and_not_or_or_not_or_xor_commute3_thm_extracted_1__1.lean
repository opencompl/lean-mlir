
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem and_not_or_or_not_or_xor_commute3_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 32),
  ((x_2 ||| x_1) ^^^ -1#32) &&& x ||| (x_1 ^^^ x_2 ||| x) ^^^ -1#32 = (x_2 ||| x_1) &&& (x_1 ^^^ x_2 ||| x) ^^^ -1#32 :=
sorry