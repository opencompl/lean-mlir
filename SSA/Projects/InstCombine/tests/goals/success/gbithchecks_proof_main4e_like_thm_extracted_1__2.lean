
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem main4e_like_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 &&& x_1 == x_1) &&& ofBool (x_2 &&& x == x) = 1#1 →
    1#32 = zeroExtend 32 (ofBool (x_2 &&& (x_1 ||| x) != x_1 ||| x)) :=
sorry