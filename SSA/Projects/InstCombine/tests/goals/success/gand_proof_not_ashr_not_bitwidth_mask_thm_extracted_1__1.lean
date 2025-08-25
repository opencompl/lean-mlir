
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem not_ashr_not_bitwidth_mask_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬6#8 ≥ ↑8 → (x_1.sshiftRight' 6#8 ^^^ -1#8) &&& x = x &&& (x_1.sshiftRight' 6#8 ^^^ -1#8) :=
sorry