
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem orn_and_cmp_2_logical_thm.extracted_1._3 : ∀ (x x_1 : BitVec 16) (x_2 : BitVec 1),
  x_2 = 1#1 → ¬ofBool (x ≤ₛ x_1) = 1#1 → ofBool (x_1 <ₛ x) = 1#1 :=
sorry