
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ne_umin3_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 + 3#32 <ᵤ x) = 1#1 → ofBool (x_1 + 3#32 != x) = ofBool (x <ᵤ x_1 + 3#32) :=
sorry