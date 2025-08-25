
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test15e_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ofBool (x &&& 128#32 != 0#32) = 1#1 → ¬1#32 ≥ ↑32 → 256#32 = x <<< 1#32 &&& 256#32 :=
sorry