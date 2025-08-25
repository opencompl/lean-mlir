
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test2_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (-1#32 <ₛ x_1) ||| ofBool (-1#32 <ₛ x) = ofBool (-1#32 <ₛ x_1 &&& x) :=
sorry