
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem and_or3_thm.extracted_1._5 : ∀ (x : BitVec 1) (x_1 x_2 : BitVec 32) (x_3 : BitVec 1),
  x_3 &&& ofBool (x_2 == x_1) = 1#1 → ¬x_3 = 1#1 → x = 0#1 :=
sorry