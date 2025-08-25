
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sge_and_max_commute_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool (x_1 == 127#8) &&& ofBool (x ≤ₛ x_1) = ofBool (x_1 == 127#8) :=
sorry