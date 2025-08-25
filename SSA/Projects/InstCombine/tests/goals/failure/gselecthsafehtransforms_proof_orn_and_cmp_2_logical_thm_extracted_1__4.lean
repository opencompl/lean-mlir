
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem orn_and_cmp_2_logical_thm.extracted_1._4 : ∀ (x x_1 : BitVec 16) (x_2 : BitVec 1),
  ¬x_2 = 1#1 → 0#1 = 1#1 → 1#1 = ofBool (x_1 <ₛ x) :=
sorry