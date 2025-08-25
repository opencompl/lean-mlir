
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test2_thm.extracted_1._1 : ∀ (x x_1 : BitVec 999),
  ofBool (x_1 &&& 65280#999 != x &&& 65280#999) = ofBool ((x_1 ^^^ x) &&& 65280#999 != 0#999) :=
sorry