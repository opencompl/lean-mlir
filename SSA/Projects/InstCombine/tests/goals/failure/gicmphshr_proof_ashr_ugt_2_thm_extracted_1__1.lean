
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_ugt_2_thm.extracted_1._1 : ∀ (x : BitVec 4),
  ¬1#4 ≥ ↑4 → ofBool (2#4 <ᵤ x.sshiftRight' 1#4) = ofBool (5#4 <ᵤ x) :=
sorry