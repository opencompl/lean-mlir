
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem main2_logical_thm.extracted_1._3 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 1#32 == 0#32) = 1#1 →
    ofBool (x &&& 2#32 == 0#32) = 1#1 → 0#32 = zeroExtend 32 (ofBool (x &&& 3#32 == 3#32)) :=
sorry