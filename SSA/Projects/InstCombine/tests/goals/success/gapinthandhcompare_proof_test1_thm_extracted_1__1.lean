
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test1_thm.extracted_1._1 : ∀ (x x_1 : BitVec 33),
  ofBool (x_1 &&& 65280#33 != x &&& 65280#33) = ofBool ((x_1 ^^^ x) &&& 65280#33 != 0#33) :=
sorry