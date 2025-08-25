
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_ult_14_thm.extracted_1._1 : ∀ (x : BitVec 4),
  ¬1#4 ≥ ↑4 → ofBool (x.sshiftRight' 1#4 <ᵤ BitVec.ofInt 4 (-2)) = ofBool (x <ᵤ BitVec.ofInt 4 (-4)) :=
sorry