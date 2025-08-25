
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test1_logical_thm.extracted_1._3 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 ^^^ 5#32 == 10#32) = 1#1 → ofBool (x_1 == 15#32) = 1#1 → ofBool (x_1 ^^^ 5#32 == x) = 1#1 :=
sorry