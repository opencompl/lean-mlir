
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem positive_biggerlshr_shlnsw_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬(6#8 ≥ ↑8 ∨ True ∧ (x >>> 6#8 <<< 3#8).sshiftRight' 3#8 ≠ x >>> 6#8 ∨ 3#8 ≥ ↑8) →
    ¬3#8 ≥ ↑8 → x >>> 6#8 <<< 3#8 = x >>> 3#8 &&& 24#8 :=
sorry