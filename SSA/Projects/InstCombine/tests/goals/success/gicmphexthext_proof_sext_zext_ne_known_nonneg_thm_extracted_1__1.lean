
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sext_zext_ne_known_nonneg_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬6#8 = 0 → ofBool (signExtend 32 x_1 != zeroExtend 32 (x / 6#8)) = ofBool (x_1 != x / 6#8) :=
sorry