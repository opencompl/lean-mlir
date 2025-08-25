
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sext_zext_slt_known_nonneg_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ofBool (signExtend 32 x_1 <ₛ zeroExtend 32 (x &&& 126#8)) = ofBool (x_1 <ₛ x &&& 126#8) :=
sorry