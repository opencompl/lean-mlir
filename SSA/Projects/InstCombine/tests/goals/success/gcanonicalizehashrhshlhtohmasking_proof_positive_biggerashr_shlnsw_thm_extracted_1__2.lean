
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem positive_biggerashr_shlnsw_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬(6#8 ≥ ↑8 ∨ True ∧ (x.sshiftRight' 6#8 <<< 3#8).sshiftRight' 3#8 ≠ x.sshiftRight' 6#8 ∨ 3#8 ≥ ↑8) →
    ¬3#8 ≥ ↑8 → x.sshiftRight' 6#8 <<< 3#8 = x.sshiftRight' 3#8 &&& BitVec.ofInt 8 (-8) :=
sorry