
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem both_sides_fold_eq_thm.extracted_1._3 : ∀ (x : BitVec 32) (x_1 : BitVec 1),
  ¬x_1 = 1#1 → ofBool (x == x) = x_1 ^^^ 1#1 :=
sorry