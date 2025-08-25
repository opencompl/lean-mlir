
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (13#32 <ᵤ x) &&& ofBool (x == 15#32) = ofBool (x == 15#32) :=
sorry