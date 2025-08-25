
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashrsgt_02_14_thm.extracted_1._1 : ∀ (x : BitVec 4),
  ¬2#4 ≥ ↑4 → ofBool (BitVec.ofInt 4 (-2) <ₛ x.sshiftRight' 2#4) = ofBool (BitVec.ofInt 4 (-5) <ₛ x) :=
sorry