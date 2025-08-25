
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test22_thm.extracted_1._1 : ∀ (x : BitVec 14),
  ¬7#14 ≥ ↑14 → ofBool (x <<< 7#14 == 0#14) = ofBool (x &&& 127#14 == 0#14) :=
sorry