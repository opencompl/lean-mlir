
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ult_to_slt_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool (x_1 ^^^ BitVec.ofInt 8 (-128) <ᵤ x ^^^ BitVec.ofInt 8 (-128)) = ofBool (x_1 <ₛ x) :=
sorry