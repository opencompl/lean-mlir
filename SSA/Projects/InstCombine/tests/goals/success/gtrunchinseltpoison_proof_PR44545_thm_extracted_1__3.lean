
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem PR44545_thm.extracted_1._3 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 == 0#32) = 1#1 →
    ¬(True ∧ x.saddOverflow 1#32 = true ∨ True ∧ x.uaddOverflow 1#32 = true) →
      ¬(True ∧ (truncate 16 (x + 1#32)).saddOverflow (-1#16) = true) → truncate 16 (x + 1#32) + -1#16 = truncate 16 x :=
sorry