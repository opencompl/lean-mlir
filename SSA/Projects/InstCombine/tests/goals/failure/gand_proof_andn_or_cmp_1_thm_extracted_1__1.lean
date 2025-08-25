
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem andn_or_cmp_1_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 37),
  ofBool (x_2 ≤ₛ x_1) &&& (ofBool (42#37 <ᵤ x) ||| ofBool (x_1 <ₛ x_2)) = ofBool (x_2 ≤ₛ x_1) &&& ofBool (42#37 <ᵤ x) :=
sorry