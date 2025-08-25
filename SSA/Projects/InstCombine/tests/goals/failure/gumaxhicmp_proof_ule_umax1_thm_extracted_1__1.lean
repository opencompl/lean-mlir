
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ule_umax1_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (x <ᵤ x_1) = 1#1 → ofBool (x_1 ≤ᵤ x_1) = ofBool (x ≤ᵤ x_1) :=
sorry