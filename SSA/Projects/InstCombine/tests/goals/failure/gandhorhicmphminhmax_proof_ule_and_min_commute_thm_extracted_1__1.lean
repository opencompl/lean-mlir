
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ule_and_min_commute_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool (x_1 == 0#8) &&& ofBool (x_1 ≤ᵤ x) = ofBool (x_1 == 0#8) :=
sorry