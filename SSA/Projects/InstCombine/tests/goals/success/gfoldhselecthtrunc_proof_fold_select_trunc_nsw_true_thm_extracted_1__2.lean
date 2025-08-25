
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem fold_select_trunc_nsw_true_thm.extracted_1._2 : ∀ (x x_1 : BitVec 128),
  ¬(True ∧ signExtend 128 (truncate 1 x_1) ≠ x_1) → truncate 1 x_1 = 1#1 → x_1 = -1#128 :=
sorry