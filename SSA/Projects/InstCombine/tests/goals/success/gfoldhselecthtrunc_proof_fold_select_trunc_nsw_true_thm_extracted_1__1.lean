
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem fold_select_trunc_nsw_true_thm.extracted_1._1 : ∀ (x : BitVec 128),
  ¬(True ∧ signExtend 128 (truncate 1 x) ≠ x) → truncate 1 x = 1#1 → x = -1#128 :=
sorry