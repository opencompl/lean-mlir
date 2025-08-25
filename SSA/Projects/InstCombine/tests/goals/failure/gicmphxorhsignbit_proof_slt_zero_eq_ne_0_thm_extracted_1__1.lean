
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem slt_zero_eq_ne_0_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬31#32 ≥ ↑32 → ofBool (zeroExtend 32 (ofBool (x != 0#32)) == x >>> 31#32) = ofBool (x <ₛ 1#32) :=
sorry