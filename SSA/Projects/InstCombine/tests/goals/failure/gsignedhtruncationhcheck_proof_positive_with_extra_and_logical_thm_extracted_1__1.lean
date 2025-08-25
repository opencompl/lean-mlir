
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem positive_with_extra_and_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(ofBool (x + 128#32 <ᵤ 256#32) = 1#1 ∧ ofBool (-1#32 <ₛ x) = 1#1) → ofBool (x <ᵤ 128#32) = 1#1 → False :=
sorry