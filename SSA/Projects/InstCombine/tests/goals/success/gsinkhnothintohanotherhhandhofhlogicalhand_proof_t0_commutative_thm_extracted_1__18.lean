
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t0_commutative_thm.extracted_1._18 : ∀ (x x_1 : BitVec 8) (x_2 : BitVec 1) (x_3 x_4 : BitVec 8),
  ¬ofBool (x_4 == x_3) = 1#1 → ¬ofBool (x_4 != x_3) = 1#1 → ¬0#1 = 1#1 → ¬x_2 = 1#1 → x = x_1 :=
sorry