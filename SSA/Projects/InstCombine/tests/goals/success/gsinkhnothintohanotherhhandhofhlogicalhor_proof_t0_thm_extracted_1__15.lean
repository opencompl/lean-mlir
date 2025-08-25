
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t0_thm.extracted_1._15 : ∀ (x x_1 x_2 : BitVec 8) (x_3 : BitVec 1),
  ¬x_3 ^^^ 1#1 = 1#1 → x_3 = 1#1 → ¬ofBool (x_2 == x_1) = 1#1 → ¬ofBool (x_2 != x_1) = 1#1 → False :=
sorry