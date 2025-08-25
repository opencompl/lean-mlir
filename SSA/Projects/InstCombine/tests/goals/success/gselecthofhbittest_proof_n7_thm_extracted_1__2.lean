
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem n7_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 2#32 != 0#32) = 1#1 → ¬ofBool (x &&& 2#32 == 0#32) = 1#1 → 1#32 = x &&& 1#32 :=
sorry