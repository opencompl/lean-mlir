
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem f_t15_t01_t09_thm.extracted_1._1 : ∀ (x : BitVec 40),
  ¬(31#40 ≥ ↑40 ∨ 16#32 ≥ ↑32) →
    15#40 ≥ ↑40 ∨ True ∧ signExtend 40 (truncate 32 (x.sshiftRight' 15#40)) ≠ x.sshiftRight' 15#40 → False :=
sorry