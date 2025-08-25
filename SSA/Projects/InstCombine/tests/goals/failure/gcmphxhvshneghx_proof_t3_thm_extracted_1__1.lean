
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t3_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ (0#8).ssubOverflow x = true) → ofBool (0#8 - x ≤ₛ x) = ofBool (-1#8 <ₛ x) :=
sorry