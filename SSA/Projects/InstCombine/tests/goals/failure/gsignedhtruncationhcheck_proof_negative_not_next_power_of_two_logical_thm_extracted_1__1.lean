
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem negative_not_next_power_of_two_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (-1#32 <ₛ x) = 1#1 → ofBool (x + 64#32 <ᵤ 256#32) = ofBool (x <ᵤ 192#32) :=
sorry