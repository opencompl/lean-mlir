
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test15_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬1#32 ≥ ↑32 →
    ¬(1#32 ≥ ↑32 ∨ True ∧ (8#32).ssubOverflow (x.sshiftRight' 1#32) = true) →
      8#64 - signExtend 64 (x.sshiftRight' 1#32) = signExtend 64 (8#32 - x.sshiftRight' 1#32) :=
sorry