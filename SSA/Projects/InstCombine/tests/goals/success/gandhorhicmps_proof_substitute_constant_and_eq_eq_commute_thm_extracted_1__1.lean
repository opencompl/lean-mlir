
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem substitute_constant_and_eq_eq_commute_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool (x_1 == x) &&& ofBool (x_1 == 42#8) = ofBool (x_1 == 42#8) &&& ofBool (x == 42#8) :=
sorry