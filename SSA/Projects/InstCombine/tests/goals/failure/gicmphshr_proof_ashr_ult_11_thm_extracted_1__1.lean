
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_ult_11_thm.extracted_1._1 : ∀ (x : BitVec 4),
  ¬1#4 ≥ ↑4 → ofBool (x.sshiftRight' 1#4 <ᵤ BitVec.ofInt 4 (-5)) = ofBool (-1#4 <ₛ x) :=
sorry