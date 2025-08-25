
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem andn_or_cmp_4_logical_thm.extracted_1._3 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 == x) = 1#1 → ¬ofBool (x_1 != x) = 1#1 → True → ofBool (x_1 != x) = 0#1 :=
sorry