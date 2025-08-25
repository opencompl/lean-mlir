
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem PR2330_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬x ≥ ↑32 → ofBool (1#32 <<< x &&& 1#32 == 0#32) = ofBool (x != 0#32) :=
sorry