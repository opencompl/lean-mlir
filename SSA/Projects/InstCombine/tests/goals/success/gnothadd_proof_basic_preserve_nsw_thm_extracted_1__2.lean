
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem basic_preserve_nsw_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ (x_1 ^^^ -1#8).saddOverflow x = true) →
    ¬(True ∧ x_1.ssubOverflow x = true) → (x_1 ^^^ -1#8) + x ^^^ -1#8 = x_1 - x :=
sorry