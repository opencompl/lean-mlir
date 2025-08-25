
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem add_nsw_or_and_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ (x_1 ||| x).saddOverflow (x_1 &&& x) = true) → True ∧ x_1.saddOverflow x = true → False :=
sorry