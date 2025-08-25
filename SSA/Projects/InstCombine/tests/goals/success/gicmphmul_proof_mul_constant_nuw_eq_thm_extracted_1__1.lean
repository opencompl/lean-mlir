
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem mul_constant_nuw_eq_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ x_1.umulOverflow 22#32 = true ∨ True ∧ x.umulOverflow 22#32 = true) →
    ofBool (x_1 * 22#32 == x * 22#32) = ofBool (x_1 == x) :=
sorry