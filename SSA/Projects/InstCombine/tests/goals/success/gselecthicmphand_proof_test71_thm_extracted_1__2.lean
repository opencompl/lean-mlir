
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test71_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 128#32 != 0#32) = 1#1 → ¬ofBool (x &&& 128#32 == 0#32) = 1#1 → 42#32 = 40#32 :=
sorry