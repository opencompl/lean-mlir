
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_negative_combined_sub_signed_overflow_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ (127#8).ssubOverflow x = true) → ofBool (127#8 - x <ₛ -1#8) = 0#1 :=
sorry