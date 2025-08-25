
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ne_smin4_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x <ₛ x_1 + 3#32) = 1#1 → ofBool (x_1 + 3#32 != x_1 + 3#32) = ofBool (x <ₛ x_1 + 3#32) :=
sorry