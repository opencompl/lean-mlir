
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_lshr_wrong_cond_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (-1#32 ≤ₛ x_1) = 1#1 →
    ¬x ≥ ↑32 → ofBool (BitVec.ofInt 32 (-2) <ₛ x_1) = 1#1 → x_1.sshiftRight' x = x_1 >>> x :=
sorry