
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem and_consts_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (4#32 &&& x == 0#32) = 1#1 → 1#1 = ofBool (x &&& 12#32 != 12#32) :=
sorry