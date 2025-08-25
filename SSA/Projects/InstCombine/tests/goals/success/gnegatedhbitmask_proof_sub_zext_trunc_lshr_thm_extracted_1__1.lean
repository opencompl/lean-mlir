
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sub_zext_trunc_lshr_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬15#64 ≥ ↑64 →
    16#32 ≥ ↑32 ∨ 31#32 ≥ ↑32 ∨ True ∧ ((truncate 32 x <<< 16#32).sshiftRight' 31#32).saddOverflow 10#32 = true →
      False :=
sorry