
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem or_not_xor_common_op_commute5_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 8),
  x_2 ^^^ x_1 ||| (x_1 ^^^ -1#8 ||| x) = x ||| x_2 &&& x_1 ^^^ -1#8 :=
sorry