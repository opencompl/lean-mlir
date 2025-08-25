
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem and_or3_commuted_thm.extracted_1._6 : ∀ (x x_1 : BitVec 1) (x_2 x_3 : BitVec 32),
  ¬ofBool (x_3 == x_2) &&& x_1 = 1#1 → x_1 = 1#1 → ofBool (x_3 != x_2) = 1#1 → x_1 = 1#1 :=
sorry