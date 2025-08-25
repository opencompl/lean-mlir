
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sext_zext_uge_known_nonneg_op0_wide_thm.extracted_1._2 : ∀ (x : BitVec 8) (x_1 : BitVec 16),
  ¬(True ∧ (x &&& 12#8).msb = true) →
    ofBool (zeroExtend 32 (x &&& 12#8) ≤ᵤ signExtend 32 x_1) = ofBool (zeroExtend 16 (x &&& 12#8) ≤ᵤ x_1) :=
sorry