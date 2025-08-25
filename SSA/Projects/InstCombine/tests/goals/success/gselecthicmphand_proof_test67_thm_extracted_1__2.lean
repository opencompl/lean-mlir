
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test67_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬ofBool (x &&& 4#16 != 0#16) = 1#1 → ¬ofBool (x &&& 4#16 == 0#16) = 1#1 → 42#32 = 40#32 :=
sorry