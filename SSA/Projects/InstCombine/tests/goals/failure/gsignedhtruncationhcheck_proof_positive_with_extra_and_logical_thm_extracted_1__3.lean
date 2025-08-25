
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem positive_with_extra_and_logical_thm.extracted_1._3 : ∀ (x : BitVec 1) (x_1 : BitVec 32),
  ¬(ofBool (x_1 + 128#32 <ᵤ 256#32) = 1#1 ∧ ofBool (-1#32 <ₛ x_1) = 1#1) → ofBool (x_1 <ᵤ 128#32) = 1#1 → 0#1 = x :=
sorry