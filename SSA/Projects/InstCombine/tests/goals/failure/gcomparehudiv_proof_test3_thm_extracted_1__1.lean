
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test3_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32), ¬x = 0 → ofBool (x_1 / x != 0#32) = ofBool (x ≤ᵤ x_1) :=
sorry