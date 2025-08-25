
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test15h_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 8#32 != 0#32) = 1#1 → BitVec.ofInt 32 (-9) = x &&& 8#32 ^^^ -1#32 :=
sorry