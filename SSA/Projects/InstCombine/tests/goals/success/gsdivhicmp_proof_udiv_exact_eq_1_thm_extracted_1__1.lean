
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem udiv_exact_eq_1_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ x_1.umod x ≠ 0 ∨ x = 0) → ofBool (x_1 / x != 1#8) = ofBool (x_1 != x) :=
sorry