
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_bitwidth_mask_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬7#8 ≥ ↑8 → ofBool (x_1 <ₛ 0#8) = 1#1 → x_1.sshiftRight' 7#8 &&& x = x :=
sorry