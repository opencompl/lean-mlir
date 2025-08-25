
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test7_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬ofBool (x <ₛ 1#32) = 1#1 → ofBool (x == 0#32) = 1#1 → 0#1 = 1#1 → False :=
sorry