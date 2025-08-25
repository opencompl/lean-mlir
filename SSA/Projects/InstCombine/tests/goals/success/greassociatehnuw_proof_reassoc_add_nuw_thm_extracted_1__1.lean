
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem reassoc_add_nuw_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ x.uaddOverflow 4#32 = true ∨ True ∧ (x + 4#32).uaddOverflow 64#32 = true) →
    True ∧ x.uaddOverflow 68#32 = true → False :=
sorry