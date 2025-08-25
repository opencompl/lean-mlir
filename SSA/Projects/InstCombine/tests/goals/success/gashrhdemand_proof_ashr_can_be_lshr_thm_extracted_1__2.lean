
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_can_be_lshr_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(True ∧ x >>> 16#32 <<< 16#32 ≠ x ∨
        16#32 ≥ ↑32 ∨ True ∧ signExtend 32 (truncate 16 (x.sshiftRight' 16#32)) ≠ x.sshiftRight' 16#32) →
    ¬(True ∧ x >>> 16#32 <<< 16#32 ≠ x ∨ 16#32 ≥ ↑32 ∨ True ∧ zeroExtend 32 (truncate 16 (x >>> 16#32)) ≠ x >>> 16#32) →
      truncate 16 (x.sshiftRight' 16#32) = truncate 16 (x >>> 16#32) :=
sorry