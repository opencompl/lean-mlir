
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem main4f_like_logical_thm.extracted_1._7 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 &&& x_1 != x_1) = 1#1 → ¬ofBool (x_2 &&& x_1 == x_1) = 1#1 → True → 0#32 = zeroExtend 32 0#1 :=
sorry