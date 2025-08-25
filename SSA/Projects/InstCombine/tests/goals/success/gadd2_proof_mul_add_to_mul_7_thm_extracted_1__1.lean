
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem mul_add_to_mul_7_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬(True ∧ x.smulOverflow 32767#16 = true ∨ True ∧ x.saddOverflow (x * 32767#16) = true) → 15#16 ≥ ↑16 → False :=
sorry