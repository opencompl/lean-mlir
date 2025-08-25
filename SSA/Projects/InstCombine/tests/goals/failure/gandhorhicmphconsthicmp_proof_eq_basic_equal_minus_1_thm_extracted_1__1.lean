
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem eq_basic_equal_minus_1_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool (x_1 == -1#8) ||| ofBool (x <ᵤ x_1 + 1#8) = ofBool (x ≤ᵤ x_1) :=
sorry