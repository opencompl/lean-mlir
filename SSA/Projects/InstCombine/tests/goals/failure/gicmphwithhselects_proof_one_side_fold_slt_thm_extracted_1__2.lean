
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem one_side_fold_slt_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32) (x_2 : BitVec 1),
  ¬x_2 = 1#1 → ofBool (x <ₛ x) = 0#1 :=
sorry