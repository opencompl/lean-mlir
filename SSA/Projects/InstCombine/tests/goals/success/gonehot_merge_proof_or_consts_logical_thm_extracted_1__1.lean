
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem or_consts_logical_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (4#32 &&& x != 0#32) = 1#1 → ofBool (8#32 &&& x != 0#32) = ofBool (x &&& 12#32 == 12#32) :=
sorry