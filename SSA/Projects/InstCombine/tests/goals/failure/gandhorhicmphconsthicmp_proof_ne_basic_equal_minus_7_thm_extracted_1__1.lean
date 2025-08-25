
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ne_basic_equal_minus_7_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool (x_1 != BitVec.ofInt 8 (-7)) &&& ofBool (x_1 + 7#8 ≤ᵤ x) = ofBool (x_1 + 6#8 <ᵤ x) :=
sorry