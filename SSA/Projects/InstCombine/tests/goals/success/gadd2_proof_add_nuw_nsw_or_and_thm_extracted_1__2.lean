
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem add_nuw_nsw_or_and_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ (x_1 ||| x).saddOverflow (x_1 &&& x) = true ∨ True ∧ (x_1 ||| x).uaddOverflow (x_1 &&& x) = true) →
    ¬(True ∧ x_1.saddOverflow x = true ∨ True ∧ x_1.uaddOverflow x = true) → (x_1 ||| x) + (x_1 &&& x) = x_1 + x :=
sorry