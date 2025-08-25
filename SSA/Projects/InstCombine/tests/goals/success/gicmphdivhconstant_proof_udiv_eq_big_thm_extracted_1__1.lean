
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem udiv_eq_big_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬x = 0 → ofBool (x_1 / x == BitVec.ofInt 8 (-128)) = ofBool (x_1 == BitVec.ofInt 8 (-128)) &&& ofBool (x == 1#8) :=
sorry