
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem main15_logical_thm.extracted_1._4 : ∀ (x : BitVec 32),
  ¬ofBool (0#16 ≤ₛ truncate 16 x) = 1#1 →
    ¬ofBool (x &&& 32896#32 == 32896#32) = 1#1 → ¬ofBool (0#8 ≤ₛ truncate 8 x) = 1#1 → 1#32 = 2#32 :=
sorry