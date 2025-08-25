
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_lshr_shift_wrong_pred2_thm.extracted_1._2 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (0#32 ≤ₛ x_2) = 1#1 → ¬x ≥ ↑32 → ¬ofBool (x_2 <ₛ 0#32) = 1#1 → x_1.sshiftRight' x = x_1 >>> x :=
sorry