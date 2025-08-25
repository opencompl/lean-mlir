
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem udiv_eq_umax_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬x = 0 → ofBool (x_1 / x == -1#8) = ofBool (x_1 == -1#8) &&& ofBool (x == 1#8) :=
sorry