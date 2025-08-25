
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_mul_negative_nsw_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬(True ∧ x.smulOverflow 52#64 = true ∨ 2#64 ≥ ↑64) →
    True ∧ x.smulOverflow 52#64 = true ∨ True ∧ (x * 52#64) >>> 2#64 <<< 2#64 ≠ x * 52#64 ∨ 2#64 ≥ ↑64 → False :=
sorry