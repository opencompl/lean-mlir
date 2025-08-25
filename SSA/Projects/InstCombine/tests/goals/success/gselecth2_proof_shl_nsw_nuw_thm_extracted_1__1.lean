
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_nsw_nuw_thm.extracted_1._1 : ∀ (x : BitVec 1),
  x = 1#1 →
    ¬(True ∧ (7#8 <<< 3#8).sshiftRight' 3#8 ≠ 7#8 ∨ True ∧ 7#8 <<< 3#8 >>> 3#8 ≠ 7#8 ∨ 3#8 ≥ ↑8) → 7#8 <<< 3#8 = 56#8 :=
sorry