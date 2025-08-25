
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem main4e_like_logical_thm.extracted_1._11 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 &&& x_1 == x_1) = 1#1 →
    ¬ofBool (x_2 &&& x_1 != x_1) = 1#1 → 0#1 = 1#1 → 0#32 = zeroExtend 32 (ofBool (x_2 &&& x != x)) :=
sorry