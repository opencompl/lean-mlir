
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_lshr_wrong_operands_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (0#32 ≤ₛ x_1) = 1#1 → ¬x ≥ ↑32 → ¬ofBool (x_1 <ₛ 0#32) = 1#1 → x_1 >>> x = x_1.sshiftRight' x :=
sorry