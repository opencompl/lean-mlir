
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem main5f_like_logical_thm.extracted_1._6 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 &&& x_1 != x_2) = 1#1 →
    ofBool (x_2 &&& x_1 == x_2) = 1#1 → ¬True → 0#32 = zeroExtend 32 (ofBool (x_2 &&& x == x_2)) :=
sorry