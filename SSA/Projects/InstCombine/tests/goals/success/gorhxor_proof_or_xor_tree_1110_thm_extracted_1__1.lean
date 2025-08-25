
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem or_xor_tree_1110_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 32),
  x_2 * 42#32 ^^^ (x_1 * 42#32 ^^^ x * 42#32) ||| x_2 * 42#32 ^^^ x * 42#32 =
    x_2 * 42#32 ^^^ x * 42#32 ||| x_1 * 42#32 :=
sorry