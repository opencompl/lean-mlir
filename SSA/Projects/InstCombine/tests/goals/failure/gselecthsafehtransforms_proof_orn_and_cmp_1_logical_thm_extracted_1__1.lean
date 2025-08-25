
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem orn_and_cmp_1_logical_thm.extracted_1._1 : ∀ (x : BitVec 1) (x_1 x_2 : BitVec 37),
  ¬ofBool (x_2 ≤ₛ x_1) = 1#1 → x = 1#1 → ofBool (x_1 <ₛ x_2) = x :=
sorry