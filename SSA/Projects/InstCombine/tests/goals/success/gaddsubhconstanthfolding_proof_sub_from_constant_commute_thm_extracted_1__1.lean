
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sub_from_constant_commute_thm.extracted_1._1 : ∀ (x x_1 : BitVec 5),
  ¬(True ∧ (10#5).ssubOverflow x = true ∨ True ∧ (x_1 * x_1).saddOverflow (10#5 - x) = true) →
    x_1 * x_1 + (10#5 - x) = x_1 * x_1 - x + 10#5 :=
sorry