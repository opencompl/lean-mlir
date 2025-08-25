
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem trunc_unsigned_nsw_sext_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 32),
  ¬(True ∧ signExtend 32 (truncate 16 x_1) ≠ x_1) →
    ofBool (truncate 16 x_1 <ᵤ signExtend 16 x) = ofBool (x_1 <ᵤ signExtend 32 x) :=
sorry