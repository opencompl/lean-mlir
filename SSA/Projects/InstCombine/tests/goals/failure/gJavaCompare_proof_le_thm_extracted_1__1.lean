
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem le_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 <ₛ x) = 1#1 → ofBool (-1#32 ≤ₛ 0#32) = ofBool (x_1 ≤ₛ x) :=
sorry