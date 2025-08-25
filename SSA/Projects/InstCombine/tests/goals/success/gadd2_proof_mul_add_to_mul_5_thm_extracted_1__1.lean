
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem mul_add_to_mul_5_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬(True ∧ x.smulOverflow 3#16 = true ∨
        True ∧ x.smulOverflow 7#16 = true ∨ True ∧ (x * 3#16).saddOverflow (x * 7#16) = true) →
    True ∧ x.smulOverflow 10#16 = true → False :=
sorry