
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem zext_sext_ule_known_nonneg_op0_wide_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 9),
  ¬254#9 = 0 → ofBool (zeroExtend 32 (x_1 % 254#9) ≤ᵤ signExtend 32 x) = ofBool (x_1 % 254#9 ≤ᵤ signExtend 9 x) :=
sorry