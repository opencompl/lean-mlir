
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem mul_constant_partial_nuw_eq_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ x.umulOverflow 44#32 = true) →
    ofBool (x_1 * 44#32 == x * 44#32) = ofBool ((x_1 ^^^ x) &&& 1073741823#32 == 0#32) :=
sorry