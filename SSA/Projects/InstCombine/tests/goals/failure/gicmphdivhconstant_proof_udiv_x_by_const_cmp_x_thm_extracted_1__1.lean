
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem udiv_x_by_const_cmp_x_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬123#32 = 0 → ofBool (x / 123#32 <ₛ x) = ofBool (0#32 <ₛ x) :=
sorry