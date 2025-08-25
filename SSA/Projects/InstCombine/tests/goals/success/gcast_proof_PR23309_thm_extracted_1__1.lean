
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem PR23309_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ (x_1 + BitVec.ofInt 32 (-4)).ssubOverflow x = true) →
    truncate 1 (x_1 + BitVec.ofInt 32 (-4) - x) = truncate 1 (x_1 - x) :=
sorry