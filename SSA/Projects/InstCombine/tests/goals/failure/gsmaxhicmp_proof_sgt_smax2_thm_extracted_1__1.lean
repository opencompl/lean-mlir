
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sgt_smax2_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x <ₛ x_1) = 1#1 → ofBool (x <ₛ x) = ofBool (x <ₛ x_1) :=
sorry