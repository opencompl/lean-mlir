
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem main3e_like_logical_thm.extracted_1._8 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (x_2 &&& x_1 == 0#32) = 1#1 →
    ¬ofBool (x_2 &&& x_1 != 0#32) = 1#1 →
      ¬ofBool (x_2 &&& x == 0#32) = 1#1 → 1#32 = zeroExtend 32 (ofBool (x_2 &&& x != 0#32)) :=
sorry