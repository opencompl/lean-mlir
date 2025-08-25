
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem main7e_logical_thm.extracted_1._11 : ∀ (x x_1 x_2 x_3 x_4 : BitVec 32),
  ofBool (x_4 &&& x_3 &&& x_2 == x_4 &&& x_3) = 1#1 →
    ¬ofBool (x_4 &&& x_3 &&& x_2 != x_4 &&& x_3) = 1#1 →
      ofBool (x_1 &&& x &&& x_2 == x_1 &&& x) = 1#1 → 0#32 = zeroExtend 32 (ofBool (x_1 &&& x &&& x_2 != x_1 &&& x)) :=
sorry