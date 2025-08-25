
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sdiv2_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ x.smod 8#32 ≠ 0 ∨ (8#32 == 0 || 32 != 1 && x == intMin 32 && 8#32 == -1) = true) →
    True ∧ x >>> 3#32 <<< 3#32 ≠ x ∨ 3#32 ≥ ↑32 → False :=
sorry