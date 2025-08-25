
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem main3f_like_logical_thm.extracted_1._3 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 &&& x != 0#32) = 1#1 → ¬ofBool (x_1 &&& x == 0#32) = 1#1 → True → 0#32 = zeroExtend 32 0#1 :=
sorry