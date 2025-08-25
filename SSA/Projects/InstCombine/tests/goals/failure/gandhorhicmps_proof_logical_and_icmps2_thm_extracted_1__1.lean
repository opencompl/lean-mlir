
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem logical_and_icmps2_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 1),
  x_1 = 1#1 → ofBool (x <ₛ -1#32) = 1#1 → ofBool (x == 10086#32) = 0#1 :=
sorry