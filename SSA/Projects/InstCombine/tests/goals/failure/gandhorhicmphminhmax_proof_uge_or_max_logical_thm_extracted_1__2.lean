
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem uge_or_max_logical_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬ofBool (x ≤ᵤ x_1) = 1#1 → ofBool (x_1 == -1#8) = ofBool (x ≤ᵤ x_1) :=
sorry