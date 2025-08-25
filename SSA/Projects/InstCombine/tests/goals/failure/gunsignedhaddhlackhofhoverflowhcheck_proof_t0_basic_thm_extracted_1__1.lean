
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t0_basic_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8), ofBool (x ≤ᵤ x_1 + x) = ofBool (x_1 ≤ᵤ x ^^^ -1#8) :=
sorry