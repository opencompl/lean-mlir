
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem zext_sext_ugt_known_nonneg_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool (signExtend 32 x <ᵤ zeroExtend 32 (x_1 &&& 127#8)) = ofBool (x <ᵤ x_1 &&& 127#8) :=
sorry