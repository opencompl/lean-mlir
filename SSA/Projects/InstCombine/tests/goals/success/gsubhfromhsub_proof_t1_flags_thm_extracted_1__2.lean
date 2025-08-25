
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t1_flags_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 8),
  ¬(True ∧ x_2.ssubOverflow x_1 = true ∨
        True ∧ x_2.usubOverflow x_1 = true ∨
          True ∧ (x_2 - x_1).ssubOverflow x = true ∨ True ∧ (x_2 - x_1).usubOverflow x = true) →
    ¬(True ∧ x_1.saddOverflow x = true ∨
          True ∧ x_1.uaddOverflow x = true ∨
            True ∧ x_2.ssubOverflow (x_1 + x) = true ∨ True ∧ x_2.usubOverflow (x_1 + x) = true) →
      x_2 - x_1 - x = x_2 - (x_1 + x) :=
sorry