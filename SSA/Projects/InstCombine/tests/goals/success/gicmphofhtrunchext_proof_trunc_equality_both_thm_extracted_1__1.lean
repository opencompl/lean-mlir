
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem trunc_equality_both_thm.extracted_1._1 : ∀ (x x_1 : BitVec 16),
  ¬(True ∧ signExtend 16 (truncate 8 x_1) ≠ x_1 ∨
        True ∧ zeroExtend 16 (truncate 8 x_1) ≠ x_1 ∨
          True ∧ signExtend 16 (truncate 8 x) ≠ x ∨ True ∧ zeroExtend 16 (truncate 8 x) ≠ x) →
    ofBool (truncate 8 x_1 == truncate 8 x) = ofBool (x_1 == x) :=
sorry