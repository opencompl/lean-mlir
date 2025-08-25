
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_or2_logical_thm.extracted_1._3 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 ≤ₛ -1#32) = 1#1 → ofBool (x_1 <ₛ 0#32) = 1#1 → ofBool (x &&& 2147483647#32 <ₛ x_1) = 1#1 :=
sorry