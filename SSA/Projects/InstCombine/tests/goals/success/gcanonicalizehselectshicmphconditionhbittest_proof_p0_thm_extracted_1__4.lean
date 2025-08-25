
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem p0_thm.extracted_1._4 : ∀ (x x_1 x_2 : BitVec 8),
  ¬ofBool (x_2 &&& 1#8 == 1#8) = 1#1 → ¬ofBool (x_2 &&& 1#8 == 0#8) = 1#1 → x = x_1 :=
sorry