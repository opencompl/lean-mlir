
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem or_xor_and_commuted2_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  x_1 * x_1 ^^^ (x * x ^^^ -1#32) ||| x * x = x * x ||| x_1 * x_1 ^^^ -1#32 :=
sorry