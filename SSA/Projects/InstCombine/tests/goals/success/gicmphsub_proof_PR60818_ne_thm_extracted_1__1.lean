
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem PR60818_ne_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (0#32 - x != x) = ofBool (x &&& 2147483647#32 != 0#32) :=
sorry