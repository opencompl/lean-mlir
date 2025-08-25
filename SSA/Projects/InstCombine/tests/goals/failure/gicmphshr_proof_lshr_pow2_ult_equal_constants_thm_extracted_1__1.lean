
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_pow2_ult_equal_constants_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬x ≥ ↑32 → ofBool (16#32 >>> x <ᵤ 16#32) = ofBool (x != 0#32) :=
sorry