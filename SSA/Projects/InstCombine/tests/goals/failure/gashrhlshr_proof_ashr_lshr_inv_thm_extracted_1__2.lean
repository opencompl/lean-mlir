
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_lshr_inv_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 <ₛ 1#32) = 1#1 → ¬x ≥ ↑32 → x_1 >>> x = x_1.sshiftRight' x :=
sorry