
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem or_xor_xor_normal_binops_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 32),
  x_2 ^^^ x_1 ^^^ (x_2 ^^^ x_1) &&& (x ^^^ x_1) ||| x ^^^ x_1 ^^^ (x_2 ^^^ x_1) &&& (x ^^^ x_1) = x_2 ^^^ x :=
sorry