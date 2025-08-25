
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_ugt_14_thm.extracted_1._1 : ∀ (x : BitVec 4),
  ¬1#4 ≥ ↑4 → ofBool (BitVec.ofInt 4 (-2) <ᵤ x.sshiftRight' 1#4) = ofBool (BitVec.ofInt 4 (-3) <ᵤ x) :=
sorry