
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem negative3_logical_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 <ₛ x_1 &&& 2147483647#32) = 1#1 → ofBool (0#32 ≤ₛ x) = ofBool (-1#32 <ₛ x) :=
sorry