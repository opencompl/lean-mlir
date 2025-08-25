
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem main2_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 1#32 == 0#32) ||| ofBool (x &&& 2#32 == 0#32) = 1#1 →
    0#32 = zeroExtend 32 (ofBool (x &&& 3#32 == 3#32)) :=
sorry