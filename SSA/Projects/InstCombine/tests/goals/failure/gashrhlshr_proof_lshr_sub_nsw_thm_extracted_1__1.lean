
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_sub_nsw_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ x_1.ssubOverflow x = true ∨ 31#32 ≥ ↑32) → (x_1 - x) >>> 31#32 = zeroExtend 32 (ofBool (x_1 <ₛ x)) :=
sorry