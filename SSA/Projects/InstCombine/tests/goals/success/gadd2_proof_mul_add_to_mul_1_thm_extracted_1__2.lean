
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem mul_add_to_mul_1_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬(True ∧ x.smulOverflow 8#16 = true ∨ True ∧ x.saddOverflow (x * 8#16) = true) →
    ¬(True ∧ x.smulOverflow 9#16 = true) → x + x * 8#16 = x * 9#16 :=
sorry