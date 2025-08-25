
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem slt_zero_thm.extracted_1._1 : ∀ (x x_1 : BitVec 4),
  ofBool (x_1 <ₛ 0#4) ^^^ ofBool (x <ₛ 0#4) = ofBool (x_1 ^^^ x <ₛ 0#4) :=
sorry