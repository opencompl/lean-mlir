
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem slt_zero_ult_i1_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 1),
  ¬31#32 ≥ ↑32 → ofBool (zeroExtend 32 x_1 <ᵤ x >>> 31#32) = ofBool (x <ₛ 0#32) &&& (x_1 ^^^ 1#1) :=
sorry