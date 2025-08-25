
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem reassoc_x2_add_nuw_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ x_1.uaddOverflow 4#32 = true ∨
        True ∧ x.uaddOverflow 8#32 = true ∨ True ∧ (x_1 + 4#32).uaddOverflow (x + 8#32) = true) →
    ¬(True ∧ x_1.uaddOverflow x = true ∨ True ∧ (x_1 + x).uaddOverflow 12#32 = true) →
      x_1 + 4#32 + (x + 8#32) = x_1 + x + 12#32 :=
sorry