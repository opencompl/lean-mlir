
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sgt_smax4_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 + 3#32 <ₛ x) = 1#1 → ofBool (x_1 + 3#32 <ₛ x_1 + 3#32) = ofBool (x_1 + 3#32 <ₛ x) :=
sorry