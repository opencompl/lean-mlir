
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem andn_or_cmp_4_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 32),
  (ofBool (x_2 == x_1) ||| ofBool (42#32 <ᵤ x)) &&& ofBool (x_2 != x_1) = ofBool (42#32 <ᵤ x) &&& ofBool (x_2 != x_1) :=
sorry