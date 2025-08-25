
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test69_and_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 128#32 != 0#32) = 1#1 → ¬ofBool (x_1 &&& 128#32 == 0#32) = 1#1 → x &&& 2#32 = x :=
sorry