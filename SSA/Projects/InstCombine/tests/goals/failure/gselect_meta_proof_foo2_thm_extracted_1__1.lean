
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem foo2_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (2#32 <ₛ x_1) = 1#1 → ¬(True ∧ x_1.ssubOverflow x = true) → x_1 - x = x_1 + (0#32 - x) :=
sorry