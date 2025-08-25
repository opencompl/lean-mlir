
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashrsgt_01_13_thm.extracted_1._1 : ∀ (x : BitVec 4),
  ¬1#4 ≥ ↑4 → ofBool (BitVec.ofInt 4 (-3) <ₛ x.sshiftRight' 1#4) = ofBool (BitVec.ofInt 4 (-5) <ₛ x) :=
sorry