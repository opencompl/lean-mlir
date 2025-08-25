
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem negative4_logical_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 != x &&& 2147483647#32) = 1#1 →
    ofBool (0#32 ≤ₛ x_1) = ofBool (x_1 != x &&& 2147483647#32) &&& ofBool (-1#32 <ₛ x_1) :=
sorry