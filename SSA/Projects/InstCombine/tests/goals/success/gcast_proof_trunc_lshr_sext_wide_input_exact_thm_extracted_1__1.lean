
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem trunc_lshr_sext_wide_input_exact_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬(True ∧ signExtend 32 x >>> 9#32 <<< 9#32 ≠ signExtend 32 x ∨ 9#32 ≥ ↑32) →
    True ∧ x >>> 9#16 <<< 9#16 ≠ x ∨
        9#16 ≥ ↑16 ∨ True ∧ signExtend 16 (truncate 8 (x.sshiftRight' 9#16)) ≠ x.sshiftRight' 9#16 →
      False :=
sorry