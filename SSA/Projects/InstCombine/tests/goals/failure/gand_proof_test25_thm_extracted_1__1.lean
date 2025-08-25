
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test25_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (50#32 ≤ₛ x) &&& ofBool (x <ₛ 100#32) = ofBool (x + BitVec.ofInt 32 (-50) <ᵤ 50#32) :=
sorry