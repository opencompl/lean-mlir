
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem main3_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 7#32 == 0#32) &&& ofBool (x &&& 48#32 == 0#32) = 1#1 →
    0#32 = zeroExtend 32 (ofBool (x &&& 55#32 != 0#32)) :=
sorry