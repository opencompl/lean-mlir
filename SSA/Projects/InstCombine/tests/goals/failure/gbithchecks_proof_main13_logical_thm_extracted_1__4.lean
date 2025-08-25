
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem main13_logical_thm.extracted_1._4 : ∀ (x : BitVec 32),
  ¬ofBool (truncate 16 x <ₛ 0#16) = 1#1 → ¬ofBool (x &&& 32896#32 == 32896#32) = 1#1 → 0#1 = 1#1 → 2#32 = 1#32 :=
sorry