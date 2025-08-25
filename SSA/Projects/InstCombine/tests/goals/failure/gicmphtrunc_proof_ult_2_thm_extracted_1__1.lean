
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ult_2_thm.extracted_1._1 : ∀ (x : BitVec 32), ofBool (truncate 8 x <ᵤ 2#8) = ofBool (x &&& 254#32 == 0#32) :=
sorry