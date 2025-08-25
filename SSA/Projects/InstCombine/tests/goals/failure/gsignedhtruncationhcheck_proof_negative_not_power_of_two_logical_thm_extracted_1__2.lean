
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem negative_not_power_of_two_logical_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (-1#32 <ₛ x) = 1#1 → 0#1 = ofBool (x == 0#32) :=
sorry