
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem annihilate_xor_common_op_commute2_thm.extracted_1._1 : ∀ (x x_1 x_2 x_3 : BitVec 4),
  x_3 * x_3 ^^^ (x_2 ^^^ x_1) ^^^ x ^^^ x_2 = x_1 ^^^ x_3 * x_3 ^^^ x :=
sorry