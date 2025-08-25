
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem scalar_i32_lshr_and_negC_eq_X_is_constant2_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬x ≥ ↑32 → ofBool (268435456#32 >>> x &&& BitVec.ofInt 32 (-8) == 0#32) = ofBool (25#32 <ᵤ x) :=
sorry