
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashrsgt_01_15_thm.extracted_1._1 : ∀ (x : BitVec 4),
  ¬1#4 ≥ ↑4 → ofBool (-1#4 <ₛ x.sshiftRight' 1#4) = ofBool (-1#4 <ₛ x) :=
sorry