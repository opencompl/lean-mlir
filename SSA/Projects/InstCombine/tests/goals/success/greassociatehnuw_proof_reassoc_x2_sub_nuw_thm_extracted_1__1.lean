
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem reassoc_x2_sub_nuw_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ x_1.usubOverflow 4#32 = true ∨
        True ∧ x.usubOverflow 8#32 = true ∨ True ∧ (x_1 - 4#32).usubOverflow (x - 8#32) = true) →
    x_1 - 4#32 - (x - 8#32) = x_1 - x + 4#32 :=
sorry