
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem reassoc_x2_mul_nuw_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ x_1.umulOverflow 5#32 = true ∨
        True ∧ x.umulOverflow 9#32 = true ∨ True ∧ (x_1 * 5#32).umulOverflow (x * 9#32) = true) →
    True ∧ (x_1 * x).umulOverflow 45#32 = true → False :=
sorry