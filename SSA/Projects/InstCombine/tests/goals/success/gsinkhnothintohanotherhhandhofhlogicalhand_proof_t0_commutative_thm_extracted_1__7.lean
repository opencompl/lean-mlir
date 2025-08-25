
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t0_commutative_thm.extracted_1._7 : ∀ (x x_1 x_2 : BitVec 8),
  ¬ofBool (x_2 == x_1) = 1#1 → ¬ofBool (x_2 != x_1) = 1#1 → ¬0#1 = 1#1 → False :=
sorry