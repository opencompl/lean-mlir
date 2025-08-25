
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem main4d_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 7#32 != 7#32) ||| ofBool (x &&& 16#32 == 0#32) = 1#1 →
    1#32 = zeroExtend 32 (ofBool (x &&& 23#32 == 23#32)) :=
sorry