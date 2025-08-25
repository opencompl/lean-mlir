
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_slt_nuw_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 32),
  ¬(True ∧ signExtend 32 (truncate 8 x_1) ≠ x_1 ∨
        True ∧ zeroExtend 32 (truncate 8 x_1) ≠ x_1 ∨
          True ∧ signExtend 16 (truncate 8 x) ≠ x ∨ True ∧ zeroExtend 16 (truncate 8 x) ≠ x) →
    ofBool (truncate 8 x_1 <ₛ truncate 8 x) = ofBool (x_1 <ₛ zeroExtend 32 x) :=
sorry