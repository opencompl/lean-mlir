
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t22_sign_check_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 <ₛ 0#32) = 1#1 → ofBool (-1#32 <ₛ x_1) = 1#1 → -1#32 = x :=
sorry