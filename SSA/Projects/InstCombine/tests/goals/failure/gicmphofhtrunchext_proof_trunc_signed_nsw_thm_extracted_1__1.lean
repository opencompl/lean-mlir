
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem trunc_signed_nsw_thm.extracted_1._1 : ∀ (x x_1 : BitVec 16),
  ¬(True ∧ signExtend 16 (truncate 8 x_1) ≠ x_1 ∨ True ∧ signExtend 16 (truncate 8 x) ≠ x) →
    ofBool (truncate 8 x_1 <ₛ truncate 8 x) = ofBool (x_1 <ₛ x) :=
sorry