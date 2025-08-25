
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem trunc_unsigned_nuw_thm.extracted_1._1 : ∀ (x x_1 : BitVec 16),
  ¬(True ∧ zeroExtend 16 (truncate 8 x_1) ≠ x_1 ∨ True ∧ zeroExtend 16 (truncate 8 x) ≠ x) →
    ofBool (truncate 8 x_1 <ᵤ truncate 8 x) = ofBool (x_1 <ᵤ x) :=
sorry