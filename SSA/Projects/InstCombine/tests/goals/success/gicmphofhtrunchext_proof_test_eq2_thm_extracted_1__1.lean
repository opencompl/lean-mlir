
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_eq2_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 16),
  ¬(True ∧ signExtend 16 (truncate 8 x_1) ≠ x_1 ∨ True ∧ signExtend 32 (truncate 8 x) ≠ x) →
    ofBool (truncate 8 x_1 == truncate 8 x) = ofBool (x_1 == truncate 16 x) :=
sorry