
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test12_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 <ᵤ x) &&& ofBool (x_1 ≤ᵤ x) = ofBool (x_1 <ᵤ x) :=
sorry