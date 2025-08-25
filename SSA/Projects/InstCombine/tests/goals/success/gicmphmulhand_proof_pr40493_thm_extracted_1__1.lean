
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem pr40493_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x * 12#32 &&& 4#32 == 0#32) = ofBool (x &&& 1#32 == 0#32) :=
sorry