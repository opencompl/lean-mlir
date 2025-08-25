
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem trunc_equality_nsw_sext_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 32),
  ¬(True ∧ signExtend 32 (truncate 16 x_1) ≠ x_1) →
    ofBool (truncate 16 x_1 != signExtend 16 x) = ofBool (x_1 != signExtend 32 x) :=
sorry