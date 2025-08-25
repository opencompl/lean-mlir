
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem abs_must_be_positive_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (0#32 ≤ₛ x) = 1#1 → ¬(True ∧ (0#32).ssubOverflow x = true) → ofBool (0#32 ≤ₛ 0#32 - x) = 1#1 :=
sorry