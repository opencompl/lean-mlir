
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test31_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ofBool (truncate 32 x &&& 42#32 == 10#32) = ofBool (x &&& 42#64 == 10#64) :=
sorry