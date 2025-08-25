
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(12#32 ≥ ↑32 ∨ 12#32 ≥ ↑32) → ofBool (x <<< 12#32 >>> 12#32 != 0#32) = ofBool (x &&& 1048575#32 != 0#32) :=
sorry