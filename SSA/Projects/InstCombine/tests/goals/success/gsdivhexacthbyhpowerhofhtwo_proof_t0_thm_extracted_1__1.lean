
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t0_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ x.smod 32#8 ≠ 0 ∨ (32#8 == 0 || 8 != 1 && x == intMin 8 && 32#8 == -1) = true) →
    True ∧ x >>> 5#8 <<< 5#8 ≠ x ∨ 5#8 ≥ ↑8 → False :=
sorry