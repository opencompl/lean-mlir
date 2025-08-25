
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem positive_biggershl_shlnuwnsw_ashrexact_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬(True ∧ x >>> 3#8 <<< 3#8 ≠ x ∨
        3#8 ≥ ↑8 ∨
          True ∧ (x.sshiftRight' 3#8 <<< 6#8).sshiftRight' 6#8 ≠ x.sshiftRight' 3#8 ∨
            True ∧ x.sshiftRight' 3#8 <<< 6#8 >>> 6#8 ≠ x.sshiftRight' 3#8 ∨ 6#8 ≥ ↑8) →
    ¬(True ∧ (x <<< 3#8).sshiftRight' 3#8 ≠ x ∨ True ∧ x <<< 3#8 >>> 3#8 ≠ x ∨ 3#8 ≥ ↑8) →
      x.sshiftRight' 3#8 <<< 6#8 = x <<< 3#8 :=
sorry