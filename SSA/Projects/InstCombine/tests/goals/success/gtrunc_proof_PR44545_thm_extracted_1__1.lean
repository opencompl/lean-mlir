
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem PR44545_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x == 0#32) = 1#1 →
    ¬(True ∧ (truncate 16 0#32).saddOverflow (-1#16) = true) → truncate 16 0#32 + -1#16 = -1#16 :=
sorry