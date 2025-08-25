
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ne_smin1_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 <ₛ x) = 1#1 → ofBool (x != x_1) = ofBool (x <ₛ x_1) :=
sorry