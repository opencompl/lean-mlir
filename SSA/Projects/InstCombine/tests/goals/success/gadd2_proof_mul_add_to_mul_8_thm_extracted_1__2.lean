
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem mul_add_to_mul_8_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬(True ∧ x.smulOverflow 16383#16 = true ∨
        True ∧ x.smulOverflow 16384#16 = true ∨ True ∧ (x * 16383#16).saddOverflow (x * 16384#16) = true) →
    ¬(True ∧ x.smulOverflow 32767#16 = true) → x * 16383#16 + x * 16384#16 = x * 32767#16 :=
sorry