
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem andn_or_cmp_2_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 16),
  (ofBool (42#16 <ᵤ x_2) ||| ofBool (x ≤ₛ x_1)) &&& ofBool (x_1 <ₛ x) = ofBool (42#16 <ᵤ x_2) &&& ofBool (x_1 <ₛ x) :=
sorry