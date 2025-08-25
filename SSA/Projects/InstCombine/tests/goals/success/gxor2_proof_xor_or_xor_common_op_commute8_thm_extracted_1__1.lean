
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem xor_or_xor_common_op_commute8_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 32),
  (x_2 ||| x_1) ^^^ (x ^^^ x_1) = x_2 &&& (x_1 ^^^ -1#32) ^^^ x :=
sorry