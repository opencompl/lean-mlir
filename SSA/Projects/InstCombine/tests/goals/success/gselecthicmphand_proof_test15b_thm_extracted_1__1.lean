
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test15b_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 32#32 == 0#32) = 1#1 → 32#32 = x &&& 32#32 ^^^ 32#32 :=
sorry