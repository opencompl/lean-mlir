
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem add_nsw_thm.extracted_1._1 : ∀ (x : BitVec 1),
  ¬x = 1#1 → ¬(True ∧ (7#8).saddOverflow 64#8 = true) → 7#8 + 64#8 = 71#8 :=
sorry