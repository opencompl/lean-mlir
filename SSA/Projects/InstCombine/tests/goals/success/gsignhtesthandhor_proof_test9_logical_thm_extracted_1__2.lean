
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test9_logical_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& 1073741824#32 != 0#32) = 1#1 → 0#1 = ofBool (x &&& BitVec.ofInt 32 (-1073741824) == 1073741824#32) :=
sorry