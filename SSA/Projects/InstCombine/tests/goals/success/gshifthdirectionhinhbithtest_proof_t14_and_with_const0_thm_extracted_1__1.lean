
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t14_and_with_const0_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬x ≥ ↑32 → ofBool (x_1 <<< x &&& 1#32 == 0#32) = ofBool (x_1 &&& 1#32 >>> x == 0#32) :=
sorry