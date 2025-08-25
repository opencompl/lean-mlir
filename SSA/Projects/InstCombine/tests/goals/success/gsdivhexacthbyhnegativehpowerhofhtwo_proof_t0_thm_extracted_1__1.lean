
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t0_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ x.smod (BitVec.ofInt 8 (-32)) ≠ 0 ∨
        (BitVec.ofInt 8 (-32) == 0 || 8 != 1 && x == intMin 8 && BitVec.ofInt 8 (-32) == -1) = true) →
    True ∧ x >>> 5#8 <<< 5#8 ≠ x ∨ 5#8 ≥ ↑8 ∨ True ∧ (0#8).ssubOverflow (x.sshiftRight' 5#8) = true → False :=
sorry