
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_and3_logical_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (x <ₛ x_1 &&& 2147483647#32) = 1#1 → ofBool (0#32 ≤ₛ x) = ofBool (x <ᵤ x_1 &&& 2147483647#32) :=
sorry