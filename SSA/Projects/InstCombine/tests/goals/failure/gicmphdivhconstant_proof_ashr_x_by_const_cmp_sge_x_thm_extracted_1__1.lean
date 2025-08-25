
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_x_by_const_cmp_sge_x_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬5#32 ≥ ↑32 → ofBool (x ≤ₛ x.sshiftRight' 5#32) = ofBool (x <ₛ 1#32) :=
sorry