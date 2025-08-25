
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem orn_and_cmp_2_partial_logical_thm.extracted_1._2 : ∀ (x : BitVec 1) (x_1 x_2 : BitVec 16),
  ¬ofBool (x_1 ≤ₛ x_2) &&& x = 1#1 → ofBool (x_2 <ₛ x_1) = x ||| ofBool (x_2 <ₛ x_1) :=
sorry