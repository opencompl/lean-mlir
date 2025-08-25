
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem main4e_like_logical_thm.extracted_1._3 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 &&& x == x) = 1#1 → ¬ofBool (x_1 &&& x != x) = 1#1 → 0#1 = 1#1 → False :=
sorry