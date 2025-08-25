
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ne_basic_equal_5_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool (x_1 != 5#8) &&& ofBool (x_1 + BitVec.ofInt 8 (-5) ≤ᵤ x) = ofBool (x_1 + BitVec.ofInt 8 (-6) <ᵤ x) :=
sorry