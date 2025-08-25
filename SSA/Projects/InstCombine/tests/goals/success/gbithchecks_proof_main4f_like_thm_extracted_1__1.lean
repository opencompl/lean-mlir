
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem main4f_like_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 &&& x_1 != x_1) ||| ofBool (x_2 &&& x != x) = 1#1 →
    0#32 = zeroExtend 32 (ofBool (x_2 &&& (x_1 ||| x) == x_1 ||| x)) :=
sorry