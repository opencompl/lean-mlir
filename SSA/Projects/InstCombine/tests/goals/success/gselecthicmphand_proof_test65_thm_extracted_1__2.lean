
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test65_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬ofBool (x &&& 16#64 != 0#64) = 1#1 → ¬ofBool (x &&& 16#64 == 0#64) = 1#1 → 42#32 = 40#32 :=
sorry