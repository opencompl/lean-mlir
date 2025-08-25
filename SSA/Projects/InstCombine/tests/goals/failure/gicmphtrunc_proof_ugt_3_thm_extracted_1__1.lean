
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ugt_3_thm.extracted_1._1 : ∀ (x : BitVec 32), ofBool (3#8 <ᵤ truncate 8 x) = ofBool (x &&& 252#32 != 0#32) :=
sorry