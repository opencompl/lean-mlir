
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem negative2_logical_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 <ₛ x) = 1#1 → 0#1 = ofBool (x_1 <ₛ x) &&& ofBool (-1#32 <ₛ x_1) :=
sorry