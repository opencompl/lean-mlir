
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem t1_exact_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬(True ∧ x >>> 63#64 <<< 63#64 ≠ x ∨ 63#64 ≥ ↑64) →
    ¬(True ∧ x >>> 63#64 <<< 63#64 ≠ x ∨
          63#64 ≥ ↑64 ∨ True ∧ signExtend 64 (truncate 32 (x.sshiftRight' 63#64)) ≠ x.sshiftRight' 63#64) →
      0#32 - truncate 32 (x >>> 63#64) = truncate 32 (x.sshiftRight' 63#64) :=
sorry