
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem positive_biggerShl_shlnuw_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ x <<< 10#32 >>> 10#32 ≠ x ∨ 10#32 ≥ ↑32 ∨ 5#32 ≥ ↑32) →
    True ∧ (x <<< 5#32).sshiftRight' 5#32 ≠ x ∨ True ∧ x <<< 5#32 >>> 5#32 ≠ x ∨ 5#32 ≥ ↑32 → False :=
sorry