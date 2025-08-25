
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t4_commutative_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool (x_1 ≤ᵤ x + x_1) = ofBool (x ≤ᵤ x_1 ^^^ -1#8) :=
sorry