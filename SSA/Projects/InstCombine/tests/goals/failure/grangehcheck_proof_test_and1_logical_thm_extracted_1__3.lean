
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_and1_logical_thm.extracted_1._3 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (0#32 ≤ₛ x_1) = 1#1 → ofBool (-1#32 <ₛ x_1) = 1#1 → 0#1 = ofBool (x_1 <ₛ x &&& 2147483647#32) :=
sorry