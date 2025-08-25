
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem negate_select_of_op_vs_negated_op_nsw_xyyx_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8) (x_2 : BitVec 1)
  (x_3 : BitVec 8), ¬x_2 = 1#1 → ¬(True ∧ x.ssubOverflow x_1 = true) → x_3 - (x - x_1) = x_1 - x + x_3 :=
sorry