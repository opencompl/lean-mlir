
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem fold_select_trunc_nsw_false_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ signExtend 8 (truncate 1 x) ≠ x ∨ truncate 1 x = 1#1) → x = 0#8 :=
sorry