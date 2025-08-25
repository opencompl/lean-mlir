
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem pr40493_neg2_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x * 12#32 &&& 15#32 == 0#32) = ofBool (x * 12#32 &&& 12#32 == 0#32) :=
sorry