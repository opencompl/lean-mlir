
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ugt_umax2_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x <ᵤ x_1) = 1#1 → ofBool (x <ᵤ x) = ofBool (x <ᵤ x_1) :=
sorry