
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_sle_noexact_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬3#8 ≥ ↑8 → ofBool (x.sshiftRight' 3#8 ≤ₛ 10#8) = ofBool (x <ₛ 88#8) :=
sorry