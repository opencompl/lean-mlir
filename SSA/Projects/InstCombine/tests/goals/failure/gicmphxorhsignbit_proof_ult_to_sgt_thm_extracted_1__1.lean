
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ult_to_sgt_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool (x_1 ^^^ 127#8 <ᵤ x ^^^ 127#8) = ofBool (x <ₛ x_1) :=
sorry