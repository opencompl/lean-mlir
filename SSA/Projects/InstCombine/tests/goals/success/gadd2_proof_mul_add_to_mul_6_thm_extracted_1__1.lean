
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem mul_add_to_mul_6_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ x_1.smulOverflow x = true ∨
        True ∧ x_1.smulOverflow x = true ∨
          True ∧ (x_1 * x).smulOverflow 5#32 = true ∨ True ∧ (x_1 * x).saddOverflow (x_1 * x * 5#32) = true) →
    True ∧ x_1.smulOverflow x = true ∨ True ∧ (x_1 * x).smulOverflow 6#32 = true → False :=
sorry