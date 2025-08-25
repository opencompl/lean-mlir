
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem slt_zero_slt_i1_fail_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 1),
  ¬31#32 ≥ ↑32 → ofBool (zeroExtend 32 x_1 <ₛ x >>> 31#32) = ofBool (x <ₛ 0#32) &&& (x_1 ^^^ 1#1) :=
sorry