
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test10_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 2#32 == 0#32) &&& ofBool (x <ᵤ 4#32) = ofBool (x <ᵤ 2#32) :=
sorry