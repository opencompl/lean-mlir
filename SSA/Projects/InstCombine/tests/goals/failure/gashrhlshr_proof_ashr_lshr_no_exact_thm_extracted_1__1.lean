
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_lshr_no_exact_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (-1#32 <ₛ x_1) = 1#1 → ¬x ≥ ↑32 → x_1 >>> x = x_1.sshiftRight' x :=
sorry