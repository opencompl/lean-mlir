
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_mul_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬(True ∧ x.umulOverflow 52#64 = true ∨ 2#64 ≥ ↑64) →
    ¬(True ∧ x.smulOverflow 13#64 = true ∨ True ∧ x.umulOverflow 13#64 = true) → (x * 52#64) >>> 2#64 = x * 13#64 :=
sorry