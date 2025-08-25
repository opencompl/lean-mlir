
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test8_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬16#32 ≥ ↑32 →
    ¬(16#32 ≥ ↑32 ∨ True ∧ (x.sshiftRight' 16#32).smulOverflow 32767#32 = true) →
      signExtend 64 (x.sshiftRight' 16#32) * 32767#64 = signExtend 64 (x.sshiftRight' 16#32 * 32767#32) :=
sorry