
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem mul_constant_eq_nsw_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ x_1.smulOverflow 6#32 = true ∨ True ∧ x.smulOverflow 6#32 = true) →
    ofBool (x_1 * 6#32 == x * 6#32) = ofBool (x_1 == x) :=
sorry