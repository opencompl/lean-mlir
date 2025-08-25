
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem positive_with_extra_and_thm.extracted_1._1 : ∀ (x : BitVec 1) (x_1 : BitVec 32),
  ofBool (x_1 + 128#32 <ᵤ 256#32) &&& (ofBool (-1#32 <ₛ x_1) &&& x) = ofBool (x_1 <ᵤ 128#32) &&& x :=
sorry