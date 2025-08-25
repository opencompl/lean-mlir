
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem main7e_logical_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (x_2 &&& x_1 &&& x == x_2 &&& x_1) = 1#1 →
    ofBool (x_2 &&& x_1 &&& x != x_2 &&& x_1) = 1#1 → 0#1 = 1#1 → 0#32 = zeroExtend 32 1#1 :=
sorry