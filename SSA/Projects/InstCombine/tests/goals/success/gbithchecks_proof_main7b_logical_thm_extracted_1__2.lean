
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem main7b_logical_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 == x &&& x_1) = 1#1 → ofBool (x_1 != x &&& x_1) = 1#1 → ¬0#1 = 1#1 → 1#32 = zeroExtend 32 1#1 :=
sorry