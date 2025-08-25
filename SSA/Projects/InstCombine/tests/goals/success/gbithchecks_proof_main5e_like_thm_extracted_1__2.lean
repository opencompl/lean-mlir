
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem main5e_like_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 &&& x_1 == x_2) &&& ofBool (x_2 &&& x == x_2) = 1#1 →
    1#32 = zeroExtend 32 (ofBool (x_2 &&& (x_1 &&& x) != x_2)) :=
sorry