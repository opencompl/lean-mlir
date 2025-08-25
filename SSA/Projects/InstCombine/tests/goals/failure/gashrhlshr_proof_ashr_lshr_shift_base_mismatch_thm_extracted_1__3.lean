
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_lshr_shift_base_mismatch_thm.extracted_1._3 : ∀ (x x_1 x_2 : BitVec 32),
  ¬ofBool (0#32 ≤ₛ x_2) = 1#1 → ¬x_1 ≥ ↑32 → ¬ofBool (x_2 <ₛ 0#32) = 1#1 → x.sshiftRight' x_1 = x_2 >>> x_1 :=
sorry