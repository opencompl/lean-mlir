
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem f1_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (truncate 8 x != 0#8) = 1#1 →
    ofBool (x &&& 16711680#32 != 0#32) = ofBool (truncate 8 x != 0#8) &&& ofBool (x &&& 16711680#32 != 0#32) :=
sorry