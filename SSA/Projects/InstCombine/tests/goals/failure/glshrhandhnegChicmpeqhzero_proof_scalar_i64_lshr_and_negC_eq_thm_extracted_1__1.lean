
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem scalar_i64_lshr_and_negC_eq_thm.extracted_1._1 : ∀ (x x_1 : BitVec 64),
  ¬x ≥ ↑64 → ofBool (x_1 >>> x &&& BitVec.ofInt 64 (-8589934592) == 0#64) = ofBool (x_1 >>> x <ᵤ 8589934592#64) :=
sorry