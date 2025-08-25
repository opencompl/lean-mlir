
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem one_side_fold_eq_thm.extracted_1._9 : ∀ (x x_1 x_2 : BitVec 32) (x_3 : BitVec 1),
  ¬x_3 = 1#1 → x_3 ^^^ 1#1 = 1#1 → ofBool (x_1 == x_1) = 1#1 :=
sorry