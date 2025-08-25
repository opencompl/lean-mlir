
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem slt_0_thm.extracted_1._1 : ∀ (x : BitVec 32), ofBool (truncate 8 x <ₛ 0#8) = ofBool (x &&& 128#32 != 0#32) :=
sorry