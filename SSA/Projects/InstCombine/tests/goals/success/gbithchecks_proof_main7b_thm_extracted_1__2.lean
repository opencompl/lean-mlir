
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem main7b_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 == x_1 &&& x_2) &&& ofBool (x * 42#32 == x_1 &&& x * 42#32) = 1#1 →
    1#32 = zeroExtend 32 (ofBool (x_1 &&& (x_2 ||| x * 42#32) != x_2 ||| x * 42#32)) :=
sorry