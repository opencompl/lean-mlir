
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem add_of_mul_thm.extracted_1._1 : ∀ (x x_1 x_2 : BitVec 8),
  ¬(True ∧ x_2.smulOverflow x_1 = true ∨
        True ∧ x_2.smulOverflow x = true ∨ True ∧ (x_2 * x_1).saddOverflow (x_2 * x) = true) →
    x_2 * x_1 + x_2 * x = x_2 * (x_1 + x) :=
sorry