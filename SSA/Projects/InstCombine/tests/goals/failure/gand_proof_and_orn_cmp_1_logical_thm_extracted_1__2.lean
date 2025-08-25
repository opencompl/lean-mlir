
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem and_orn_cmp_1_logical_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_1 <ₛ x_2) = 1#1 → ¬ofBool (42#32 <ᵤ x) = 1#1 → ofBool (x_2 ≤ₛ x_1) = ofBool (42#32 <ᵤ x) :=
sorry