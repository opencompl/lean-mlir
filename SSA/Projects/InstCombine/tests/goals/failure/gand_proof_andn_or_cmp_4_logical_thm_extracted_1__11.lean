
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem andn_or_cmp_4_logical_thm.extracted_1._11 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 == x_1) = 1#1 → ¬ofBool (x_2 != x_1) = 1#1 → ofBool (42#32 <ᵤ x) = 1#1 → ofBool (x_2 != x_1) = 0#1 :=
sorry