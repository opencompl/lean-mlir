
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sub_mask1_lshr_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬1#8 ≥ ↑8 → 6#8 ≥ ↑8 ∨ 7#8 ≥ ↑8 ∨ True ∧ ((x <<< 6#8).sshiftRight' 7#8).saddOverflow 10#8 = true → False :=
sorry