
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem main3b_logical_thm.extracted_1._3 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 7#32 == 0#32) = 1#1 → 0#1 = 1#1 → 0#32 = zeroExtend 32 (ofBool (x &&& 23#32 != 0#32)) :=
sorry