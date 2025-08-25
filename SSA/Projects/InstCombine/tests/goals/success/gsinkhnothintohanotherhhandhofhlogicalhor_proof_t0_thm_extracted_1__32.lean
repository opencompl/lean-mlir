
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t0_thm.extracted_1._32 : ∀ (x x_1 x_2 x_3 : BitVec 8) (x_4 : BitVec 1),
  ¬x_4 ^^^ 1#1 = 1#1 → ¬x_4 = 1#1 → ¬ofBool (x_3 == x_2) = 1#1 → ¬0#1 = 1#1 → x = x_1 :=
sorry