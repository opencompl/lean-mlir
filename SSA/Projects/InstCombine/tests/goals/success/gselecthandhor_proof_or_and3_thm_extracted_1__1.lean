
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem or_and3_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32) (x_2 : BitVec 1),
  x_2 ||| ofBool (x_1 == x) = 1#1 → x_2 = 1#1 → x_2 = 1#1 :=
sorry