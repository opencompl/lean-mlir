
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem main7f_logical_thm.extracted_1._7 : ∀ (x x_1 x_2 x_3 : BitVec 32),
  ¬ofBool (x_3 &&& x_2 == x_1 &&& (x_3 &&& x_2)) = 1#1 →
    ¬ofBool (x_3 &&& x_2 != x_1 &&& (x_3 &&& x_2)) = 1#1 → 0#1 = 1#1 → False :=
sorry