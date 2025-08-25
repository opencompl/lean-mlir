
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem fold_select_trunc_nsw_false_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ signExtend 8 (truncate 1 x_1) ≠ x_1) → ¬truncate 1 x_1 = 1#1 → x_1 = 0#8 :=
sorry