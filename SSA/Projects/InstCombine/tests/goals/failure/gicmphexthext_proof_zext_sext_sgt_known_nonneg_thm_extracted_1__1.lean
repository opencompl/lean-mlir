
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem zext_sext_sgt_known_nonneg_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬x_1 = 0 → ofBool (signExtend 32 x <ₛ zeroExtend 32 (127#8 / x_1)) = ofBool (x <ₛ 127#8 / x_1) :=
sorry