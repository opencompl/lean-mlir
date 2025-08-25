
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem and_orn_cmp_3_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 72),
  ofBool (x_1 <ᵤ x_2) &&& (ofBool (x_2 ≤ᵤ x_1) ||| ofBool (42#72 <ᵤ x)) = ofBool (x_1 <ᵤ x_2) &&& ofBool (42#72 <ᵤ x) :=
sorry