
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test1_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 &&& 65280#32 != x &&& 65280#32) = ofBool ((x_1 ^^^ x) &&& 65280#32 != 0#32) :=
sorry