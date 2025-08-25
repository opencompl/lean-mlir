
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_ugt_0_thm.extracted_1._1 : ∀ (x : BitVec 4),
  ¬1#4 ≥ ↑4 → ofBool (0#4 <ᵤ x.sshiftRight' 1#4) = ofBool (1#4 <ᵤ x) :=
sorry