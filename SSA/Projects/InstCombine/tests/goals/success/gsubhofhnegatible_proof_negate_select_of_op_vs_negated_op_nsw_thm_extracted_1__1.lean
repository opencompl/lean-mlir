
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem negate_select_of_op_vs_negated_op_nsw_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 1) (x_2 : BitVec 8),
  x_1 = 1#1 → ¬(True ∧ (0#8).ssubOverflow x = true) → x_2 - (0#8 - x) = x + x_2 :=
sorry