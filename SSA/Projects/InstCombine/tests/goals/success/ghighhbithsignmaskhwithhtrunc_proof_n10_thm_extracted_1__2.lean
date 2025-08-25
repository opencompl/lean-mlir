
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem n10_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬63#64 ≥ ↑64 →
    ¬(63#64 ≥ ↑64 ∨
          True ∧ signExtend 64 (truncate 32 (x.sshiftRight' 63#64)) ≠ x.sshiftRight' 63#64 ∨
            True ∧ (truncate 32 (x.sshiftRight' 63#64)).saddOverflow 1#32 = true) →
      1#32 - truncate 32 (x >>> 63#64) = truncate 32 (x.sshiftRight' 63#64) + 1#32 :=
sorry