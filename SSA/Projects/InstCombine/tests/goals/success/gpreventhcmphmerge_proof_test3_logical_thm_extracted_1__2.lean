
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test3_logical_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ x_1.ssubOverflow x = true) →
    ¬ofBool (x_1 - x == 0#32) = 1#1 → ofBool (x_1 == x) = 1#1 → ofBool (x_1 - x == 31#32) = 1#1 :=
sorry