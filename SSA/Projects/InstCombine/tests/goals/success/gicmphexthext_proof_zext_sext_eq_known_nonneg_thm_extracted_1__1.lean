
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem zext_sext_eq_known_nonneg_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬1#8 ≥ ↑8 → ofBool (zeroExtend 32 (x_1 >>> 1#8) == signExtend 32 x) = ofBool (x_1 >>> 1#8 == x) :=
sorry