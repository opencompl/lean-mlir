
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem eq_umax3_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x <ᵤ x_1 + 3#32) = 1#1 → ofBool (x_1 + 3#32 == x) = ofBool (x ≤ᵤ x_1 + 3#32) :=
sorry