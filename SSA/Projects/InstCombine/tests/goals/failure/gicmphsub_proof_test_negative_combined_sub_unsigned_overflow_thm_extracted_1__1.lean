
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_negative_combined_sub_unsigned_overflow_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬(True ∧ (10#64).usubOverflow x = true) → ofBool (10#64 - x <ᵤ 11#64) = 1#1 :=
sorry