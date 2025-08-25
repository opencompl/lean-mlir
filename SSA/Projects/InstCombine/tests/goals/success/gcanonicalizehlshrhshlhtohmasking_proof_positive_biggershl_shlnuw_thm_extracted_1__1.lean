
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem positive_biggershl_shlnuw_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(3#8 ≥ ↑8 ∨ True ∧ x >>> 3#8 <<< 6#8 >>> 6#8 ≠ x >>> 3#8 ∨ 6#8 ≥ ↑8) →
    True ∧ x <<< 3#8 >>> 3#8 ≠ x ∨ 3#8 ≥ ↑8 → False :=
sorry