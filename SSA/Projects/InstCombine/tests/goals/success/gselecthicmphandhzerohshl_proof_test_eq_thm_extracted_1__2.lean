
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_eq_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ofBool (x &&& 1073741823#32 == 0#32) = 1#1 → ¬2#32 ≥ ↑32 → 0#32 = x <<< 2#32 :=
sorry