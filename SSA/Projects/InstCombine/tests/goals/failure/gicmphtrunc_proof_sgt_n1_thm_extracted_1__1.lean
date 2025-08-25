
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sgt_n1_thm.extracted_1._1 : ∀ (x : BitVec 32), ofBool (-1#8 <ₛ truncate 8 x) = ofBool (x &&& 128#32 == 0#32) :=
sorry