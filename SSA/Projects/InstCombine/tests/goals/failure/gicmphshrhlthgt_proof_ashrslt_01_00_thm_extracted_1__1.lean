
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashrslt_01_00_thm.extracted_1._1 : ∀ (x : BitVec 4),
  ¬1#4 ≥ ↑4 → ofBool (x.sshiftRight' 1#4 <ₛ 0#4) = ofBool (x <ₛ 0#4) :=
sorry