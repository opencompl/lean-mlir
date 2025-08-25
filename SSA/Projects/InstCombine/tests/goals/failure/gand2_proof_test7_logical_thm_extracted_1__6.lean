
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test7_logical_thm.extracted_1._6 : ∀ (x : BitVec 1) (x_1 : BitVec 32),
  ofBool (x_1 <ₛ 1#32) = 1#1 → ¬ofBool (x_1 == 0#32) = 1#1 → x = 1#1 → ofBool (-1#32 <ₛ x_1) = 0#1 :=
sorry