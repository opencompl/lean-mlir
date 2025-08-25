
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashrsgt_01_02_thm.extracted_1._1 : ∀ (x : BitVec 4),
  ¬1#4 ≥ ↑4 → ofBool (2#4 <ₛ x.sshiftRight' 1#4) = ofBool (5#4 <ₛ x) :=
sorry