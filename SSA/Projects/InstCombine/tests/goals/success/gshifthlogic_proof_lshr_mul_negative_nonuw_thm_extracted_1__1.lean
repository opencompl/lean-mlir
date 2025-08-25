
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_mul_negative_nonuw_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬2#64 ≥ ↑64 → True ∧ (x * 52#64) >>> 2#64 <<< 2#64 ≠ x * 52#64 ∨ 2#64 ≥ ↑64 → False :=
sorry