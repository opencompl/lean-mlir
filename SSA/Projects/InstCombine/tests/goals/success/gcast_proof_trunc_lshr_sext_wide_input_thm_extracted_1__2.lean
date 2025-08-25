
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem trunc_lshr_sext_wide_input_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬9#32 ≥ ↑32 →
    ¬(9#16 ≥ ↑16 ∨ True ∧ signExtend 16 (truncate 8 (x.sshiftRight' 9#16)) ≠ x.sshiftRight' 9#16) →
      truncate 8 (signExtend 32 x >>> 9#32) = truncate 8 (x.sshiftRight' 9#16) :=
sorry