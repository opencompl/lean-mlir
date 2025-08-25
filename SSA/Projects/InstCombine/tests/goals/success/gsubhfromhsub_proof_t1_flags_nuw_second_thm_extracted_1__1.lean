
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t1_flags_nuw_second_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 8),
  ¬(True ∧ (x_2 - x_1).usubOverflow x = true) → x_2 - x_1 - x = x_2 - (x_1 + x) :=
sorry