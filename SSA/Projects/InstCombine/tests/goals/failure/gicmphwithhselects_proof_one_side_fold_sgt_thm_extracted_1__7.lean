
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem one_side_fold_sgt_thm.extracted_1._7 : ∀ (x x_1 : BitVec 32) (x_2 : BitVec 1),
  ¬x_2 = 1#1 → ¬x_2 ^^^ 1#1 = 1#1 → ofBool (x <ₛ x_1) = 0#1 :=
sorry