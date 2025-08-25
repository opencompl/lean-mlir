
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem slt_to_ugt_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool (x_1 ^^^ 127#8 <ₛ x ^^^ 127#8) = ofBool (x <ᵤ x_1) :=
sorry