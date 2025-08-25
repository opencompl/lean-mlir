
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem positive_biggerlshr_lshrexact_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬(True ∧ x >>> 6#8 <<< 6#8 ≠ x ∨ 6#8 ≥ ↑8 ∨ 3#8 ≥ ↑8) →
    ¬(True ∧ x >>> 3#8 <<< 3#8 ≠ x ∨ 3#8 ≥ ↑8) → x >>> 6#8 <<< 3#8 = x >>> 3#8 :=
sorry