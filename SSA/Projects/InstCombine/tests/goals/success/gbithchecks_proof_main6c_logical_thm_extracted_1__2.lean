
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem main6c_logical_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ofBool (x &&& 7#32 != 3#32) = 1#1 → ¬True → 0#32 = zeroExtend 32 (ofBool (x &&& 55#32 == 19#32)) :=
sorry