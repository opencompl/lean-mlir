
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem and_zext_eq_zero_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬x ≥ ↑32 → zeroExtend 32 (ofBool (x_1 == 0#32)) &&& (x_1 >>> x ^^^ -1#32) = zeroExtend 32 (ofBool (x_1 == 0#32)) :=
sorry