
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem positive_easyinvert_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 8),
  ofBool (x_1 <ₛ 0#8) ^^^ ofBool (x <ₛ 0#16) ^^^ 1#1 = ofBool (x_1 <ₛ 0#8) ^^^ ofBool (-1#16 <ₛ x) :=
sorry