
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_or2_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 ≤ₛ -1#32) ||| ofBool (x &&& 2147483647#32 <ₛ x_1) = ofBool (x &&& 2147483647#32 <ᵤ x_1) :=
sorry