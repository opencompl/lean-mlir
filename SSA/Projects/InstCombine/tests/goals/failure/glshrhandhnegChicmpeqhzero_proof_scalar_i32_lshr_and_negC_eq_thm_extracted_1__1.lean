
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem scalar_i32_lshr_and_negC_eq_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬x ≥ ↑32 → ofBool (x_1 >>> x &&& BitVec.ofInt 32 (-262144) == 0#32) = ofBool (x_1 >>> x <ᵤ 262144#32) :=
sorry