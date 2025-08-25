
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test7_thm.extracted_1._1 : ∀ (x : BitVec 1) (x_1 : BitVec 32),
  ofBool (x_1 <ₛ 1#32) &&& x &&& ofBool (-1#32 <ₛ x_1) = ofBool (x_1 == 0#32) &&& x :=
sorry