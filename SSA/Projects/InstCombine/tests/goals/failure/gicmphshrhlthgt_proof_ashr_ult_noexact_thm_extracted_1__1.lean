
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_ult_noexact_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬3#8 ≥ ↑8 → ofBool (x.sshiftRight' 3#8 <ᵤ 10#8) = ofBool (x <ᵤ 80#8) :=
sorry