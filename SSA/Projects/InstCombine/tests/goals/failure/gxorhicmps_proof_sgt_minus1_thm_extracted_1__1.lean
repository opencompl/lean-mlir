
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sgt_minus1_thm.extracted_1._1 : ∀ (x x_1 : BitVec 4),
  ofBool (-1#4 <ₛ x_1) ^^^ ofBool (-1#4 <ₛ x) = ofBool (x_1 ^^^ x <ₛ 0#4) :=
sorry