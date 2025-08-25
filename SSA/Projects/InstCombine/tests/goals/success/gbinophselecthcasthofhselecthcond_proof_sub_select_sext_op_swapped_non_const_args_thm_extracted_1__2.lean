
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sub_select_sext_op_swapped_non_const_args_thm.extracted_1._2 : ∀ (x : BitVec 6) (x_1 : BitVec 1),
  ¬x_1 = 1#1 → signExtend 6 x_1 - x = 0#6 - x :=
sorry