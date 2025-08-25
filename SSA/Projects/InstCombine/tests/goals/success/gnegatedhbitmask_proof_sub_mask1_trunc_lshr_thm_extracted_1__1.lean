
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sub_mask1_trunc_lshr_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬15#64 ≥ ↑64 →
    48#64 ≥ ↑64 ∨
        63#64 ≥ ↑64 ∨
          True ∧ signExtend 64 (truncate 8 ((x <<< 48#64).sshiftRight' 63#64)) ≠ (x <<< 48#64).sshiftRight' 63#64 ∨
            True ∧ (truncate 8 ((x <<< 48#64).sshiftRight' 63#64)).saddOverflow 10#8 = true →
      False :=
sorry