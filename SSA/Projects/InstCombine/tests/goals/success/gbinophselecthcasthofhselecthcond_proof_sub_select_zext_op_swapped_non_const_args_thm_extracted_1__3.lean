
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sub_select_zext_op_swapped_non_const_args_thm.extracted_1._3 : ∀ (x x_1 : BitVec 6) (x_2 : BitVec 1),
  x_2 = 1#1 → zeroExtend 6 x_2 - x_1 = 1#6 - x_1 :=
sorry