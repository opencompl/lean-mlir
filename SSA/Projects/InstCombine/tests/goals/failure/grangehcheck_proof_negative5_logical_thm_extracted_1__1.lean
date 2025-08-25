
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem negative5_logical_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 <ₛ x &&& 2147483647#32) = 1#1 → ofBool (0#32 ≤ₛ x_1) = 1#1 :=
sorry