
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem PR42691_8_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x <ₛ 14#32) &&& ofBool (x != BitVec.ofInt 32 (-2147483648)) =
    ofBool (x + 2147483647#32 <ᵤ BitVec.ofInt 32 (-2147483635)) :=
sorry