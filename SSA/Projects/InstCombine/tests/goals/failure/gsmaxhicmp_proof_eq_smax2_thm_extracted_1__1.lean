
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem eq_smax2_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (x <ₛ x_1) = 1#1 → ofBool (x_1 == x) = ofBool (x_1 ≤ₛ x) :=
sorry