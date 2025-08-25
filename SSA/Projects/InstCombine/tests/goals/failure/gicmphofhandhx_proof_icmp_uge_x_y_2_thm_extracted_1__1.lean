
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_uge_x_y_2_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool (x_1 * x_1 ≤ᵤ x_1 * x_1 &&& x) = ofBool (x_1 * x_1 &&& x == x_1 * x_1) :=
sorry