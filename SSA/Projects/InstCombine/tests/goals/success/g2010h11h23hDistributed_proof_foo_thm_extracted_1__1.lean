
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem foo_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ x_1.saddOverflow x = true ∨ True ∧ (x_1 + x).smulOverflow x_1 = true ∨ True ∧ x_1.smulOverflow x_1 = true) →
    (x_1 + x) * x_1 - x_1 * x_1 = x * x_1 :=
sorry