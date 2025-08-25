
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test7_logical_thm.extracted_1._8 : ∀ (x : BitVec 1) (x_1 : BitVec 32),
  ¬ofBool (x_1 <ₛ 1#32) = 1#1 → ofBool (x_1 == 0#32) = 1#1 → ¬0#1 = 1#1 → 0#1 = x :=
sorry