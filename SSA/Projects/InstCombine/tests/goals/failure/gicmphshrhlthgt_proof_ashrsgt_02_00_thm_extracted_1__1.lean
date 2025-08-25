
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashrsgt_02_00_thm.extracted_1._1 : ∀ (x : BitVec 4),
  ¬2#4 ≥ ↑4 → ofBool (0#4 <ₛ x.sshiftRight' 2#4) = ofBool (3#4 <ₛ x) :=
sorry