
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_with_5_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬x ≥ ↑32 → 5#32 <<< x &&& 1#32 = zeroExtend 32 (ofBool (x == 0#32)) :=
sorry