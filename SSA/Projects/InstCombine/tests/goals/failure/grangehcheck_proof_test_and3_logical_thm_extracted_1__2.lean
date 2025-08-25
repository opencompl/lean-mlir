
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_and3_logical_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x <ₛ x_1 &&& 2147483647#32) = 1#1 → 0#1 = ofBool (x <ᵤ x_1 &&& 2147483647#32) :=
sorry