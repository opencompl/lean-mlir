
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem substitute_constant_and_eq_ugt_swap_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool (x <ᵤ x_1) &&& ofBool (x == 42#8) = ofBool (x == 42#8) &&& ofBool (42#8 <ᵤ x_1) :=
sorry