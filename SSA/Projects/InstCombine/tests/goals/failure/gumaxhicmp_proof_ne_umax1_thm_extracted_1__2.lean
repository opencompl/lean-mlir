
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ne_umax1_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x <ᵤ x_1) = 1#1 → ofBool (x != x_1) = ofBool (x_1 <ᵤ x) :=
sorry