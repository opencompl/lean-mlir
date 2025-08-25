
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem main7d_logical_thm.extracted_1._14 : ∀ (x x_1 x_2 x_3 x_4 : BitVec 32),
  ¬ofBool (x_4 &&& (x_3 &&& x_2) == x_3 &&& x_2) = 1#1 →
    ofBool (x_4 &&& (x_3 &&& x_2) != x_3 &&& x_2) = 1#1 → ¬0#1 = 1#1 → 1#32 = zeroExtend 32 1#1 :=
sorry