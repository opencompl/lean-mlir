
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem bar_thm.extracted_1._1 : ∀ (x x_1 x_2 x_3 : BitVec 32),
  ofBool (x_2 <ₛ x_1) = 1#1 →
    x_3 &&& (signExtend 32 (ofBool (x_2 <ₛ x_1)) ^^^ -1#32) ||| x &&& signExtend 32 (ofBool (x_2 <ₛ x_1)) = x :=
sorry