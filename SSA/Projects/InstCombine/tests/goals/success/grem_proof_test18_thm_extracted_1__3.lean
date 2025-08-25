
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test18_thm.extracted_1._3 : ∀ (x : BitVec 16) (x_1 : BitVec 32),
  ¬ofBool (x &&& 4#16 != 0#16) = 1#1 → ofBool (x &&& 4#16 == 0#16) = 1#1 → ¬64#32 = 0 → x_1 % 64#32 = x_1 &&& 63#32 :=
sorry