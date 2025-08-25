
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shift_trunc_wrong_shift_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬23#32 ≥ ↑32 → ofBool (truncate 8 (x >>> 23#32) <ₛ 0#8) = ofBool (x &&& 1073741824#32 != 0#32) :=
sorry