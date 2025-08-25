
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test9_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬16#32 ≥ ↑32 →
    ¬(16#32 ≥ ↑32 ∨ True ∧ (x.sshiftRight' 16#32).smulOverflow (BitVec.ofInt 32 (-32767)) = true) →
      signExtend 64 (x.sshiftRight' 16#32) * BitVec.ofInt 64 (-32767) =
        signExtend 64 (x.sshiftRight' 16#32 * BitVec.ofInt 32 (-32767)) :=
sorry