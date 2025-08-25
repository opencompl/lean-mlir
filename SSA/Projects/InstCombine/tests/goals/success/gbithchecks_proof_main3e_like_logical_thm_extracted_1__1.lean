
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem main3e_like_logical_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 &&& x == 0#32) = 1#1 → ofBool (x_1 &&& x != 0#32) = 1#1 → 0#1 = 1#1 → 0#32 = zeroExtend 32 1#1 :=
sorry