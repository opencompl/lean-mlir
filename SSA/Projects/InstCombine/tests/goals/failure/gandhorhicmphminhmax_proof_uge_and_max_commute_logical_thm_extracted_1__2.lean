
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem uge_and_max_commute_logical_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ofBool (x_1 == -1#8) = 1#1 → ofBool (x ≤ᵤ x_1) = ofBool (x_1 == -1#8) :=
sorry