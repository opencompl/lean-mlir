
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ne_umin2_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 <ᵤ x) = 1#1 → ofBool (x_1 != x) = ofBool (x_1 <ᵤ x) :=
sorry