
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_or3_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 &&& 2147483647#32 ≤ₛ x) ||| ofBool (x <ₛ 0#32) = ofBool (x_1 &&& 2147483647#32 ≤ᵤ x) :=
sorry