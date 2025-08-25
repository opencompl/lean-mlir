
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_mul_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬(True ∧ x.umulOverflow 52#64 = true ∨ 2#64 ≥ ↑64) →
    True ∧ x.smulOverflow 13#64 = true ∨ True ∧ x.umulOverflow 13#64 = true → False :=
sorry