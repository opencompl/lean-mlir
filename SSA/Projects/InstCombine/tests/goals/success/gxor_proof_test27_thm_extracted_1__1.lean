
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test27_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 32),
  zeroExtend 32 (ofBool (x_2 ^^^ x_1 == x_2 ^^^ x)) = zeroExtend 32 (ofBool (x_1 == x)) :=
sorry