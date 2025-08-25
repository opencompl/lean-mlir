
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sub_select_sext_op_swapped_non_const_args_thm.extracted_1._4 : ∀ (x x_1 : BitVec 6) (x_2 : BitVec 1),
  ¬x_2 = 1#1 → signExtend 6 x_2 - x = 0#6 - x :=
sorry