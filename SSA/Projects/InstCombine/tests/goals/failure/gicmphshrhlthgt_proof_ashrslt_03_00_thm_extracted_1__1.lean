
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashrslt_03_00_thm.extracted_1._1 : ∀ (x : BitVec 4),
  ¬3#4 ≥ ↑4 → ofBool (x.sshiftRight' 3#4 <ₛ 0#4) = ofBool (x <ₛ 0#4) :=
sorry