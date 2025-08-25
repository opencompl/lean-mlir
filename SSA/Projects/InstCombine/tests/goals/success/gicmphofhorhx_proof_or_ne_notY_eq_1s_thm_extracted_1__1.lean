
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem or_ne_notY_eq_1s_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool (x_1 ||| x ^^^ -1#8 != x_1) = ofBool (x_1 ||| x != -1#8) :=
sorry